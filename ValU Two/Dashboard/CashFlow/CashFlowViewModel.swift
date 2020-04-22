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
    
    @Published var segement : Int = 0
    
    
    init(){
        
        do{
            let weekQuery = PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.weekly.rawValue)
            let monthQuery = PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.monthly.rawValue)
            let biMonthQuery = PredicateBuilder().generateTimeFramePredicate(timeFrame: TimeFrame.semiMonthly.rawValue)
            let weekData = try DataManager().getEntity(predicate: weekQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            let monthData = try DataManager().getEntity(predicate: monthQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            let biMonthData = try DataManager().getEntity(predicate: biMonthQuery, entityName: "TransactionDateCache") as! [TransactionDateCache]
            self.weekData = weekData
            self.monthData = monthData
            self.biMonthData = biMonthData
            
            self.selectedWeek = self.weekData.first!
            self.selectedMonth = self.monthData.first!
            self.selectedBiMonth = self.biMonthData.first!
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
        self.largestWeekAmount = findLargestWeekAmount()
    }
    
    func findLargestWeekAmount() -> Float{
        
        var largest = Float(0.0)
        for week in self.weekData{
            
            if week.income.magnitude > largest{
                largest = week.income.magnitude
            }
            if week.expenses.magnitude > largest{
                largest = week.expenses.magnitude
            }
            
        }
        return largest
    }
    
    func getViewData(selector: Int) -> [TransactionDateCache]{
        if selector == 0{
            return self.weekData
        }
        else if selector == 1{
            return self.biMonthData
        }
        else{
            return self.monthData
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
    
    

}
