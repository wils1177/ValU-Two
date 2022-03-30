//
//  TransactionRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
    
    var coordinator : TransactionRowDelegate?
    var transactionService : TransactionService
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var transaction : Transaction
    var presentationDate: String?
    
    @State var showingDetail = false
    
    init(coordinator: TransactionRowDelegate?, transaction : Transaction, transactionService: TransactionService){
        self.coordinator = coordinator
        self.transaction = transaction
        self.transactionService = transactionService
        

        self.presentationDate = getPresentationDate(date: transaction.date ?? Date())
        
        
    }
    
    func getPresentationDate(date: Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "MM-dd"
        return  df.string(from: date)
    }
    

    
    var body: some View {
        
        Button(action: {
            // What to perform
            self.coordinator?.showTransactionDetail(transaction: self.transaction)
            }) {
                // How the button looks like
                HStack{

                   
  
                        //Text(viewData.icon).font(.largeTitle)
                    if transaction.categoryMatches != nil{
                        TransactionIconView(icons: self.transactionService.getIcons(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch]))
                    }
                    
                       
                        
                    
                    

                    VStack(spacing: 5){
                        HStack{
                            Text(self.transactionService.getDisplayName(transaction: self.transaction)).font(.system(size: 17, design: .rounded)).fontWeight(.semibold).foregroundColor(colorScheme == .dark ? Color.white : Color.black).lineLimit(1)
                            Spacer()
                        }
                        HStack{
                            
                            
                            TransactionBudgetLabelsView(transaction: self.transaction, transactionService: self.transactionService)
                            Spacer()
                        }
                        
                    }//.padding(.leading, 5)
                    
                    
                    Spacer()
                    VStack(alignment: .trailing){

                        Text(self.transactionService.getAmount(transaction: self.transaction)).font(.system(size: 17, weight: .semibold, design: .rounded)).lineLimit(1).fixedSize(horizontal: true, vertical: false).foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                        
                        if transaction.pending{
                            Text("PENDING").font(.system(size: 13, weight: .medium, design: .rounded)).italic().lineLimit(1).foregroundColor(Color(.lightGray))
                        }
                        else{
                            Text(getPresentationDate(date:transaction.date ?? Date())).font(.system(size: 15, weight: .medium, design: .rounded)).italic().lineLimit(1).foregroundColor(Color(.lightGray))
                        }
                            
                        
                        
                    }.frame(maxWidth: 70)

                }
            }.buttonStyle(BorderlessButtonStyle())
             
        }
         
    
}





