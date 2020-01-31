//
//  TransactionDetailViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import MapKit

struct TransactionDetailViewData{
    var coordinate: CLLocationCoordinate2D?
    var name: String
    var amount: String
    var date: String
    //var categories : Stribg
}

class TransactionDetailViewModel: ObservableObject {
    
    var transaction : Transaction
    var viewData : TransactionDetailViewData?
    
    init(transaction: Transaction){
        self.transaction = transaction
        generateViewData()
        
    }
    
    @objc func update(_ notification:Notification){
           print("Spending Card Update Triggered")
           generateViewData()
           
       }
    

    
    func generateViewData(){
        
        print(self.transaction.location?.address)
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
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        self.viewData = TransactionDetailViewData(coordinate: coordinate, name: name, amount: String(amount), date: df.string(from: date!))
        
        
    }
    
    
    
}
