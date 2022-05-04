//
//  IncomeTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeTransactionsView: View {
    
    var coordinator : BudgetEditableCoordinator?
    
    var transactionsService = TransactionService()
    
    var service: BudgetIncomeService
    
    @ObservedObject var predictionService: IncomePredictionService
    
    init(service : BudgetIncomeService){
        self.service = service
        self.predictionService = service.incomePredictionService
    }
    
    var body: some View {
        NavigationView{
            List{
                
                Section{
                    VStack(alignment: .leading, spacing: 5){
                        Text("Estimated Income").font(.system(size: 16, design: .rounded)).foregroundColor(Color(.lightGray)).fontWeight(.bold).lineLimit(1)
                        HStack{
                            Text(CommonUtils.makeMoneyString(number: Double(predictionService.getTotalIncome()))).font(.system(size: 33, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary).fontWeight(.bold).lineLimit(1)
                            Spacer()
                        }.listRowBackground(Color.clear)
                    }
                }
                
                
                
                Section{
                    ForEach(self.service.getIncomeTransactions(), id: \.self){ transaction in
                        HStack{
                            
                            HStack{
                                VStack{
                                    Text(transaction.merchantName ?? transaction.name!).font(.system(size: 16, design: .rounded)).fontWeight(.semibold).lineLimit(2)
                                }
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text(CommonUtils.makeMoneyString(number: Double(transaction.amount * -1))).font(.system(size: 15, design: .rounded)).fontWeight(.semibold).lineLimit(1)
                                    Text(CommonUtils.getMonthDayString(date: transaction.date!)).font(.system(size: 15, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.lightGray)).lineLimit(1)
                                }
                            }.padding(.horizontal, 5)
                            
                            VStack{
                                if !self.service.incomePredictionService.isExcluded(transactionId: transaction.transactionId!){
                                    Image(systemName: "checkmark.circle.fill").foregroundColor(globalAppTheme.themeColorPrimary).font(.system(size: 25, design: .rounded))
                                }
                                else{
                                    Image(systemName: "checkmark.circle.fill").foregroundColor(Color(.lightGray).opacity(0.5)).font(.system(size: 25, design: .rounded))
                                }
                            }
                        }.padding(.vertical, 5)
                            .onTapGesture {
                            print("this")
                            if self.service.incomePredictionService.isExcluded(transactionId: transaction.transactionId!){
                                self.service.incomePredictionService.unExclude(transactionId: transaction.transactionId!)
                            }
                            else{
                                self.service.incomePredictionService.exclude(transactionId: transaction.transactionId!)
                            }
                        }
                        
                        
                        
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            
            .navigationTitle("Typical Income").navigationBarItems( trailing:
            
                            Button(action: {
                                self.coordinator?.dismiss()
                                                      }) {
                                NavigationBarTextButton(text: "Done")
                                             }
            
            )
        }
        
    }
}


