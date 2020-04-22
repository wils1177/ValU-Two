//
//  TransactionDetailViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI

struct TransactionDetailViewData{
    var coordinate: CLLocationCoordinate2D?
    var name: String
    var amount: String
    var date: String
    var accountName : String
    var icons : [String]
    var categories : [CategoryAmountViewData]
    var rawCategories : [String]
}

class CategoryAmountViewData: Hashable, ObservableObject{
    
    static func == (lhs: CategoryAmountViewData, rhs: CategoryAmountViewData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)

    }
    
    var name : String
    @Published var amount : String
    var id  : UUID
    
    init(name: String, amount: String, id:UUID){
        self.name = name
        self.amount = amount
        self.id = id
    }
}

class TransactionDetailViewModel: ObservableObject, Presentor, KeyboardDelegate {
    
    
    
    @Published var transaction : Transaction
    @Published var viewData : TransactionDetailViewData?
    @Published var isHidden : Bool
    var coordinator : TransactionRowDelegate?
    
    init(transaction: Transaction){
        self.transaction = transaction
        self.isHidden = transaction.isHidden
        generateViewData()
        
    }
    
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionDetailView(viewModel: self, transaction: self.transaction))
        vc.navigationItem.largeTitleDisplayMode = .never
        return vc
    }
    
    func getAccountName() -> String{
        let accountId = self.transaction.accountId!
        let query = PredicateBuilder().generateByAccountIdPredicate(id: accountId)
        var accountName = ""
        do{
            let account = try DataManager().getEntity(predicate: query, entityName: "AccountData") as! [AccountData]
            if account.first != nil{
                accountName = account.first!.name!
                
            }
        }
        catch{
            accountName = "No Account Found"
        }
        
        return accountName
    }
    
    func generateViewData(){
        
        var lat : Double?
        var lon : Double?
        var coordinate : CLLocationCoordinate2D?
        
        if self.transaction.location?.lat != nil{
            lat = Double(self.transaction.location!.lat!)
        }
        
        if self.transaction.location?.lon != nil{
            lon = Double(self.transaction.location!.lon!)
        }
        
        if lat != nil && lon != nil{
            coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)
        }
        
        let name = transaction.name!
        let date = transaction.date
        let amount = transaction.amount
        let accountName = getAccountName()
        let icons = getIcons(categories: self.transaction.categoryMatches?.allObjects as! [CategoryMatch])
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let categoryAmounts = createCategoryAmountViewData(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch])
        
        self.viewData = TransactionDetailViewData(coordinate: coordinate, name: name, amount: "$" + String(amount), date: df.string(from: date!), accountName: accountName, icons: icons, categories: categoryAmounts, rawCategories: self.transaction.plaidCategories!)
        
        
    }
    
    
    func getIcons(categories: [CategoryMatch]) -> [String]{
        
        var icons = [String]()
        if categories.count == 0{
            icons.append("❓")
            return icons
        }
        for match in categories{
            if match.spendingCategory!.subSpendingCategories!.count == 0{
                icons.append(match.spendingCategory!.icon!)
            }
        }
        
        return icons
        
    }
    
    func createCategoryAmountViewData(categories: [CategoryMatch]) -> [CategoryAmountViewData]{
        
        var categoryAmountViewData = [CategoryAmountViewData]()
        for match in categories{
            let name = match.spendingCategory!.icon! + " " + match.spendingCategory!.name!
            let amount = String(match.amount)
            categoryAmountViewData.append(CategoryAmountViewData(name: name, amount: amount, id: match.id!))
        }
        
        return categoryAmountViewData
        
        
        
    }
    
    func onKeyBoardSet(text: String, key: String?) {
        
        if let value = text.floatValue{
            if let uuid = key{
                updateCategoryMatchAmount(amount: value, categoryIdString: uuid)
            }
        }
        
    }
    
    func updateCategoryMatchAmount(amount: Float, categoryIdString: String){
        
        for categoryMatch in self.transaction.categoryMatches?.allObjects as! [CategoryMatch]{
            if categoryMatch.id!.uuidString == categoryIdString{
                categoryMatch.amount = amount
            }
        }
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
    }
    
    func toggleHidden(){
        self.transaction.isHidden.toggle()
        DataManager().saveDatabase()
        NotificationCenter.default.post(name: .modelUpdate, object: nil)
    }
    
    
    
}

extension String {
     struct NumFormatter {
         static let instance = NumberFormatter()
     }

     var doubleValue: Double? {
         return NumFormatter.instance.number(from: self)?.doubleValue
     }

     var integerValue: Int? {
         return NumFormatter.instance.number(from: self)?.intValue
     }
    
    var floatValue: Float? {
        return NumFormatter.instance.number(from: self)?.floatValue
    }
}
