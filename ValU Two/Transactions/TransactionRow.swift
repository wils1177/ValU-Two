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
    
    
    var transaction : Transaction
    var presentationDate: String?
    var presentationAmount : String?
    var icons : [String]
    var categoryName : String
    
    @State var showingDetail = false
    
    init(coordinator: TransactionRowDelegate?, transaction : Transaction){
        self.coordinator = coordinator
        self.transaction = transaction
        self.transactionService = TransactionService(transaction: transaction)
        
        self.categoryName = transactionService.getCategoryName(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch])
        self.icons = transactionService.getIcons(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch])
        
        self.presentationDate = getPresentationDate(date: transaction.date!)
        self.presentationAmount = getPresentationAmount(amount: transaction.amount)
        
    }
    
    func getPresentationDate(date: Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "MM-dd"
        return  df.string(from: date)
    }
    
    func getPresentationAmount(amount : Double) -> String{
        return String(format: "$%.02f", amount)
    }
    
    var body: some View {
        
        Button(action: {
            // What to perform
            self.coordinator?.showTransactionDetail(transaction: self.transaction)
            }) {
                // How the button looks like
                HStack{

                    Button(action: {
                        print("clicked the category button")
                        self.coordinator?.showEditCategory(transaction: self.transaction)
                    }){
                    ZStack{
                        
                        //Text(viewData.icon).font(.largeTitle)
                        TransactionIconView(icons: self.icons)
                    }
                    }.buttonStyle(BorderlessButtonStyle())

                    VStack{
                        HStack{
                            Text(transaction.name!).font(.headline).bold().lineLimit(1)
                            Spacer()
                        }
                        HStack{
                            Text(self.categoryName).font(.subheadline)
                            Spacer()
                        }
                        
                    }.padding(.leading, 5)
                    
                    
                    Spacer()
                    VStack{
                        HStack{
                            Spacer()
                            Text(self.presentationAmount!).font(.headline).bold().lineLimit(1)
                            
                        }
                        HStack{
                            Spacer()
                            Text(self.presentationDate!).font(.subheadline).lineLimit(1)
                            
                        }
                        
                    }.frame(maxWidth: 70)

                }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5).padding(3)
            }.buttonStyle(PlainButtonStyle())
             
        }
        
        
}





