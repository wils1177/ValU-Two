//
//  CashFlowViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

class CashFlowViewModel: ObservableObject {
    
    var weekData: [TransactionDateCache] = [TransactionDateCache]()
    var monthData: [TransactionDateCache] = [TransactionDateCache]()
    var biMonthData: [TransactionDateCache] = [TransactionDateCache]()
    @Published var selectedWeek : TransactionDateCache?
    @Published var selectedBiMonth : TransactionDateCache?
    @Published var selectedMonth : TransactionDateCache?
    
    var largestWeekAmount : Float?
    var largestBiMonthAmount : Float?
    var largestMonthAmount : Float?
    
    @Published var segement : Int = 0
    
    
    init(){
        
        do{
            let weekQuery = (PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.weekly.rawValue))
            let monthQuery = PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.monthly.rawValue)
            let biMonthQuery = PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.semiMonthly.rawValue)
            let weekData = try DataManager().getEntity(predicate: weekQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            let monthData = try DataManager().getEntity(predicate: monthQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            let biMonthData = try DataManager().getEntity(predicate: biMonthQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            
            
            self.weekData = weekData
            
            self.monthData = monthData
            self.biMonthData = biMonthData
            
            
        }catch{
            print("Could not get the data for the cash flow view!!")
        }
        
        self.weekData.sort {
            $0.startDate! > $1.startDate!
        }
        self.monthData.sort {
            $0.startDate! > $1.startDate!
        }
        self.biMonthData.sort {
            $0.startDate! > $1.startDate!
        }
        
        //self.selectedWeek = self.weekData.first!
        //self.selectedMonth = self.monthData.first!
        //self.selectedBiMonth = self.biMonthData.first!
        
        self.largestWeekAmount = findLargestAmount(amounts: self.weekData)
        self.largestMonthAmount = findLargestAmount(amounts: self.monthData)
        self.largestBiMonthAmount = findLargestAmount(amounts: self.biMonthData)
    }
    
    func findLargestAmount(amounts: [TransactionDateCache]) -> Float{
        
        var largest = Float(0.0)
        for amount in amounts{
            
            if amount.income.magnitude > largest{
                largest = amount.income.magnitude
            }
            if amount.expenses.magnitude > largest{
                largest = amount.expenses.magnitude
            }
            
        }
        return largest
    }
    
    func isSelected(timeFrame: TransactionDateCache) -> Bool{
        if self.selectedWeek != nil && timeFrame.id == self.selectedWeek!.id{
            return true
        }
        if self.selectedMonth != nil && timeFrame.id == self.selectedMonth!.id{
            return true
        }
        if self.selectedBiMonth != nil && timeFrame.id == self.selectedBiMonth!.id{
            return true
        }
        return false
    }
    
    func getViewData(selector: Int) -> [TransactionDateCache]{
        if selector == 0{
            return self.monthData
        }
        else if selector == 1{
            return self.biMonthData
        }
        else{
            return self.weekData
        }
    }
    
    func changeSelectedTimeFrame(timeFrame: TransactionDateCache){
        
        if timeFrame.timeFrame == TimeFrame.monthly.rawValue{
            self.selectedMonth = timeFrame
        }
        else if timeFrame.timeFrame == TimeFrame.semiMonthly.rawValue{
            self.selectedBiMonth = timeFrame
        }
        else if timeFrame.timeFrame == TimeFrame.weekly.rawValue{
            self.selectedWeek = timeFrame
        }
        
    }
    
    func getCurrentMonth() -> TransactionDateCache{
        
        let today = Date()
        
        for month in self.monthData{
            if (month.startDate! ... month.endDate!).contains(today){
                return month
            }
        }

        print("COULD NOT FIND A MONTH")
        return self.monthData.first!
        
    }
    
    

}
