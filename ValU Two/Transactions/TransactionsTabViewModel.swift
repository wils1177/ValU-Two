//
//  TransactionsTabViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/27/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct TransactionsTabViewData{
    //var spendingSummary : SpendingSummaryViewModel
    var transactionsThisWeek : TransactionsListViewModel
    var transactionsToday : TransactionsListViewModel
    var transactionsThisMonth : TransactionsListViewModel
}

struct ListWrapper : Hashable{
    static func == (lhs: ListWrapper, rhs: ListWrapper) -> Bool {
        return lhs.idx == rhs.idx
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(idx)

    }
    
    var spendingSummary : SpendingSummaryViewModel?
    var sectionTitle : String?
    var transactionRow: Transaction?
    var idx : Int
}

struct TransactionDateSection: Hashable{
    
    var date: Date
    var transactions: [Transaction]
    var amount: Double?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date)

    }
    
}

class TransactionsTabViewModel: ObservableObject, Presentor{
    
    
    
    @Published var transactionsThisWeek : TransactionsListViewModel?
    @Published var transactionsToday : TransactionsListViewModel?
    @Published var transactionsThisMonth : TransactionsListViewModel?
    weak var coordinator : TransactionRowDelegate?
    
    var filterModel = TransactionFilterModel()
    
    
    var rows : [ListWrapper]?
    
    init(){
        //generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionsTabView(viewModel: self, filterModel: self.filterModel))
        return vc
    }
    
    func getTransactionsList() -> [Transaction]{
        return TransactionsListViewModel(predicate: filterModel.getPredicateBasedOnState()).transactions
    }
    
    func getTransactionsByDate() -> [TransactionDateSection]{
        var transactionsByDate = [TransactionDateSection]()
        let transactions = getTransactionsList()
        
        let datesArray = transactions.compactMap { $0.date?.stripTime() }
        let datesSet = Set(datesArray)
        
        datesSet.forEach {
            let dateKey = $0
            let filterArray = transactions.filter { $0.date?.stripTime() == dateKey }
            
            
            var amount = 0.0
            for transaction in filterArray{
                
                if !transaction.isHidden{
                    let categoryMatches = transaction.categoryMatches?.allObjects as! [CategoryMatch]
                    
                    for match in categoryMatches{
                        amount = amount + Double(match.amount)
                    }
                }
                
                
            }
            
            var section = TransactionDateSection(date: dateKey, transactions: filterArray, amount: amount)
            
            section.transactions = section.transactions.sorted(by: { $0.createdDate! > $1.createdDate!})
            transactionsByDate.append(section)
        }
        
        return transactionsByDate.sorted(by: { $0.date > $1.date })
    }
    
    func refreshCompleted(){
        //self.objectWillChange.send()
    }
    
    
    
    
    
    
    
    @objc func update(_ notification:Notification){
        print("Transaction Tab Update Triggered")
        self.objectWillChange.send()
        
    }
    
}

extension Date {

    func stripTime() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        let date = Calendar.current.date(from: components)
        return date!
    }

}
