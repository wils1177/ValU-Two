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
    var transactionRow: TransactionViewData?
    var idx : Int
}

class TransactionsTabViewModel: ObservableObject, Presentor{
    
    
    
    @Published var transactionsThisWeek : TransactionsListViewModel?
    @Published var transactionsToday : TransactionsListViewModel?
    @Published var transactionsThisMonth : TransactionsListViewModel?
    
    var rows : [ListWrapper]?
    
    init(){
        generateViewData()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .modelUpdate, object: nil)
    }
    
    func configure() -> UIViewController {
        let vc = UIHostingController(rootView: TransactionsTabView(viewModel: self))
        return vc
    }
    
    func generateViewData(){
        
        let spendingSummary = SpendingSummaryViewModel()
        
        self.transactionsToday = TransactionsListViewModel(predicate: PredicateBuilder().generateTodayPredicate())
        self.transactionsThisWeek = TransactionsListViewModel(predicate: PredicateBuilder().generateThisWeekPredicate())
        self.transactionsThisMonth = TransactionsListViewModel(predicate: PredicateBuilder().generateEarlierThisMonthPredicate())
        
        self.rows = [ListWrapper]()
        var idx = 0
        let row1 = ListWrapper(spendingSummary: spendingSummary, idx: idx)
        self.rows!.append(row1)
        
        
        
        if self.transactionsToday!.viewData.count > 0 {
            
            idx = idx + 1
            let anotherRow = ListWrapper(sectionTitle: "Today", idx: idx)
            self.rows!.append(anotherRow)
            
            idx = idx + 1
            for transaction in self.transactionsToday!.viewData{
                let row = ListWrapper(transactionRow: transaction , idx: idx)
                self.rows!.append(row)
                idx = idx + 1
            }
        }
        
        
        
        if self.transactionsThisWeek!.viewData.count > 0 {
            
            idx = idx + 1
            let anotherRow = ListWrapper(sectionTitle: "Earlier This Week", idx: idx)
            self.rows!.append(anotherRow)
            
            
            idx = idx + 1
            for transaction in self.transactionsThisWeek!.viewData{
                let row = ListWrapper(transactionRow: transaction , idx: idx)
                self.rows!.append(row)
                idx = idx + 1
            }
        }
        
        
        
        
        
        if self.transactionsThisMonth!.viewData.count > 0 {
            
            idx = idx + 1
            let anotherRow = ListWrapper(sectionTitle: "Earlier This Month", idx: idx)
            self.rows!.append(anotherRow)
            
            idx = idx + 1
            for transaction in self.transactionsThisMonth!.viewData{
                let row = ListWrapper(transactionRow: transaction , idx: idx)
                self.rows!.append(row)
                idx = idx + 1
            }
        }
        
        

        

        
        
    }
    
    @objc func update(_ notification:Notification){
        print("Update Triggered")
        self.transactionsThisWeek = nil
        self.transactionsThisMonth = nil
        self.transactionsToday = nil
        generateViewData()
        
    }
    
}
