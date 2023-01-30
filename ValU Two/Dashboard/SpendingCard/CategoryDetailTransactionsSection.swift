//
//  CategoryDetailTransactionsSection.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/19/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailTransactionsSection: View {
    
    @State var transactionsHidden : Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var category : BudgetCategory
    var coordinator : BudgetsTabCoordinator
    
    var transactionService = TransactionService()
    
    var transactions : [Transaction]
    
    var model = BudgetDetailViewModel()
    
    init(category: BudgetCategory, coordinator: BudgetsTabCoordinator){
        self.category = category
        self.coordinator = coordinator
        let transactions = BudgetDetailViewModel().getTransactionsForCategory(category: category)
        self.transactions = transactions
        if self.transactions.count == 0{
            self.transactionsHidden = true
        }
    }
    
    var transactionsZeroState : some View{
        Text("No transactions for this category yet.").font(.system(size: 15, weight: .semibold, design: .rounded)).foregroundColor(Color(.gray))
        
    }
    
    var body: some View {
        
        
            
            
                // How the button looks like
            
            
            /*
            ChildCategoryCard(limit: category.limit, spent: category.getAmountSpent(), icon: category.spendingCategory!.icon!, name: category.spendingCategory!.name!, color: colorMap[Int(self.category.budgetSection!.colorCode)]).padding(.horizontal)
                .onTapGesture {
                    withAnimation{
                        self.transactionsHidden.toggle()
                    }
                }.padding(.horizontal, 5)
             */
            //Divider().padding(.leading, 20).padding(.bottom, 5).padding(.top, 5)
            
            
                if !self.transactionsHidden{
                    if self.transactions.count > 0{
                        
                        /*
                        ForEach(self.transactions.sorted(by: { $0.date! > $1.date! }), id: \.self) { transaction in
                            TransactionRow(coordinator: self.coordinator, transaction: transaction, transactionService: self.transactionService).padding(.vertical, 3)
                        }.transition(.scale)
                         */
                        
                        ForEach(self.model.getMerchangeTotalsForCategory(category: self.category), id: \.self) { totals in
                            
                        
                            Button(action: {
                                // What to perform
                                self.coordinator.showListOfTransactions(title: totals.name, list: totals.transactions)
                            }) {
                                // How the button looks like
                                HStack(alignment: .top){
                                    
                                    
                                    Text( totals.name).lineLimit(2).font(.system(size: 17, weight: .regular, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                    Spacer()
                                    Text(CommonUtils.makeMoneyString(number: totals.amount)).font(.system(size: 17, weight: .regular, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                }
                            }
                            
                            
                            
                        }
                        
                    }
                    else{
                        
                        HStack{
                            Spacer()
                            self.transactionsZeroState
                            Spacer()
                        }.transition(.scale)
                        
                        
                    }
                }
            
                
                
                
            
                    
                
                    
                   

                    
                
                
            
            
            
            
                
            
            
            
        

            
            
        }
}

