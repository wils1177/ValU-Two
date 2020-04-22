//
//  TimeFrameManager.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/5/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

class TimeFrameManager{
    
    func createInitialBudgetTimeFrames(){
        
        print("CREATING INITIAL TIME FRAMES")
        let timeFrameDefault = TimeFrame.monthly.rawValue
        let previousTimeFrame : BudgetTimeFrame? = nil
        var date = Date()
        for _ in 0..<12 {
            var newBudgetTimeFrame = DataManager().createBudgetTimeFrame(timeFrame: timeFrameDefault, startDate: date.startOfMonth!, endDate: date.endOfMonth!)
            if previousTimeFrame != nil{
                previousTimeFrame!.nextTimeFrame = newBudgetTimeFrame
            }
            date = Calendar.current.date(byAdding: .day, value: 30, to: date)!
        }
        
        DataManager().saveDatabase()
        
    }
    
    func getCurrentTimeFrame() -> BudgetTimeFrame{
        let today = Date()
        
        //First let's get the current time frame
        let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: today)
        let results = try! DataManager().getEntity(predicate: query, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
        var currentTimeFrame = results.first!
        return currentTimeFrame
        
    }
    
    func changeToWeekly(){
        
        let timeFrame = TimeFrame.weekly.rawValue
            
            let today = Date()
            
            //First let's get the current time frame
            let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: today)
            do{
                let results = try DataManager().getEntity(predicate: query, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
                var currentTimeFrame : BudgetTimeFrame? = results.first
                
                // Now we have to step through and change the time frame and start dates for each
                var rootDate = today
                while currentTimeFrame != nil{
                    currentTimeFrame!.timeFrame = timeFrame
                    currentTimeFrame!.startDate = rootDate.startOfWeek!
                    currentTimeFrame!.startDate = rootDate.endOfWeek!
                    
                    rootDate = Calendar.current.date(byAdding: .day, value: 7, to: rootDate)!
                    currentTimeFrame = currentTimeFrame!.nextTimeFrame
                }
                
                
            }
            catch{
                print("Could not update time frames")
            }

    }
    
    func changeToMonthly(){
        
        let timeFrame = TimeFrame.monthly.rawValue
            let today = Date()
            
            //First let's get the current time frame
            let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: today)
            do{
                let results = try DataManager().getEntity(predicate: query, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
                var currentTimeFrame : BudgetTimeFrame? = results.first
                
                // Now we have to step through and change the time frame and start dates for each
                var rootDate = today
                while currentTimeFrame != nil{
                    currentTimeFrame!.timeFrame = timeFrame
                    currentTimeFrame!.startDate = rootDate.startOfMonth!
                    currentTimeFrame!.startDate = rootDate.endOfMonth!
                    
                    rootDate = Calendar.current.date(byAdding: .day, value: 30, to: rootDate)!
                    currentTimeFrame = currentTimeFrame!.nextTimeFrame
                }
                
                
            }
            catch{
                print("Could not update time frames")
            }

    }
    
    func changeToSemiMonthly(){
        
        let timeFrame = TimeFrame.semiMonthly.rawValue
            
            let today = Date()
            
            //First let's get the current time frame
            let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: today)
            do{
                let results = try DataManager().getEntity(predicate: query, entityName: "BudgetTimeFrame") as! [BudgetTimeFrame]
                var currentTimeFrame : BudgetTimeFrame? = results.first
                
                // Now we have to step through and change the time frame and start dates for each
                var rootDate = today
                while currentTimeFrame != nil{
                    currentTimeFrame!.timeFrame = timeFrame
                    currentTimeFrame!.startDate = rootDate.startOfMonth!
                    currentTimeFrame!.startDate = rootDate.fifteenthOfMonth!
                    
                    if currentTimeFrame!.nextTimeFrame != nil{
                        currentTimeFrame!.nextTimeFrame!.startDate = rootDate.fifteenthOfMonth!
                        currentTimeFrame!.nextTimeFrame!.endDate = rootDate.endOfMonth!
                        currentTimeFrame = currentTimeFrame!.nextTimeFrame!.nextTimeFrame
                        rootDate = Calendar.current.date(byAdding: .day, value: 30, to: rootDate)!
                    }
                    else{
                        rootDate = Calendar.current.date(byAdding: .day, value: 16, to: rootDate)!
                        currentTimeFrame = currentTimeFrame!.nextTimeFrame
                    }
                    
                    
                }
                
                
            }
            catch{
                print("Could not update time frames")
            }

    }
    
    
    // This will create the first 60 days of time frames. 60 days is the max histoical data the app offers
    func createTransactionCaches(){
        
        createWeeks()
        createSemiMonths()
        createMonths()
    }
    
    func createWeeks(){
        
        var date = Date()
        for _ in 0..<6 {
            DataManager().createTransactionDateCache(dateFrom: date, timeFrame: TimeFrame.weekly.rawValue)
            date = Calendar.current.date(byAdding: .day, value: -7, to: date)!
        }
            
    }
    
    func createSemiMonths(){
        
        var date = Date()
        for _ in 0..<3 {
            let monthStart = date.startOfMonth!
            let monthMiddle = Calendar.current.date(byAdding: .day, value: 14, to: monthStart)!
            let monthEnd = date.endOfMonth!
            
            TransactionDateCache(startDate: monthStart, endDate: monthMiddle, timeFrame: TimeFrame.semiMonthly.rawValue, context: DataManager().context)
            TransactionDateCache(startDate: monthMiddle, endDate: monthEnd, timeFrame: TimeFrame.semiMonthly.rawValue, context: DataManager().context)
            
            date = Calendar.current.date(byAdding: .day, value: -30, to: date)!
        }
        
    }
    
    func createMonths(){
        
        var date = Date()
        for _ in 0..<6 {
            DataManager().createTransactionDateCache(dateFrom: date, timeFrame: TimeFrame.monthly.rawValue)
            date = Calendar.current.date(byAdding: .day, value: -30, to: date)!
        }
        
    }
    
    func checkIfNewEntryNeeded(){
        
        let types = [TimeFrame.monthly.rawValue, TimeFrame.weekly.rawValue, TimeFrame.semiMonthly.rawValue]
        
        let currentDate = Date()
        
        do{
            let query = PredicateBuilder().generateInBetweenDatesPredicate(executionDate: currentDate)
            let timeFrames = try DataManager().getEntity(predicate: query, entityName: "TransactionDateCache") as! [TransactionDateCache]
            
            for type in types{
                
                var match = false
                for timeFrame in timeFrames{
                    if timeFrame.timeFrame == type{
                        match = true
                    }
                }
                
                if !match{
                    
                }
                
            }
            
        }
        catch{
            print("could not look up time frames!!")
        }
    }
    
}
