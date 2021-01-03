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
    
    
    @ObservedObject var transaction : Transaction
    var presentationDate: String?
    var icons : [String]
    var categoryName : String
    var budgetName : String?
    var budgetColorInt : Int?
    var budgetIconName : String?
    
    @State var showingDetail = false
    
    init(coordinator: TransactionRowDelegate?, transaction : Transaction){
        self.coordinator = coordinator
        self.transaction = transaction
        self.transactionService = TransactionService(transaction: transaction)
        
        self.categoryName = transactionService.getCategoryName(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch])
        self.icons = transactionService.getIcons(categories: transaction.categoryMatches?.allObjects as! [CategoryMatch])
        self.budgetName = self.transactionService.getBudgetName()
        self.budgetColorInt = self.transactionService.getBudgetColorInt()
        self.budgetIconName = self.transactionService.getBudgetIconName()
        self.presentationDate = getPresentationDate(date: transaction.date!)
        
        
        
        
        
    }
    
    func getPresentationDate(date: Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "MM-dd"
        return  df.string(from: date)
    }
    

    
    var body: some View {
        //Text("sdfasd")
        
        
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
                        //TransactionIconView(icons: self.icons)
                        if budgetColorInt == 13{
                            BudgetSectionIconLarge(color: colorMap[self.budgetColorInt ?? 0] as! Color, icon: self.budgetIconName ?? "book", size: 44, multiColor: true)
                        }
                        else{
                            BudgetSectionIconLarge(color: colorMap[self.budgetColorInt ?? 0] as! Color, icon: self.budgetIconName ?? "book", size: 44)
                        }
                        
                        
                    }
                    }.buttonStyle(BorderlessButtonStyle())

                    VStack{
                        HStack{
                            Text(transaction.name ?? "missing" ).font(.headline).bold().lineLimit(1)
                            Spacer()
                        }
                        HStack{
                            
                            /*
                            if self.budgetName != nil && self.budgetColorInt != nil && self.budgetIconName != nil {
                                Image(systemName: self.budgetIconName!).font(Font.caption.weight(.bold)).foregroundColor(colorMap[self.budgetColorInt!])
                                Text(budgetName!).lineLimit(1).font(.subheadline).foregroundColor(colorMap[self.budgetColorInt!])
                                //Circle().foregroundColor(Color(.lightGray)).frame(width: 2, height: 2, alignment: .center)
                            }
                            */
                            Text(self.categoryName).font(.subheadline).foregroundColor(Color(.lightGray)).lineLimit(1)

                            Spacer()
                        }
                        
                    }.padding(.leading, 5)
                    
                    
                    Spacer()
                    VStack(alignment: .trailing){

                            Text(self.transactionService.getAmount()).font(.headline).bold().lineLimit(1).fixedSize(horizontal: true, vertical: false)
                            
                            Text(self.presentationDate ?? "Missing" ).font(.subheadline).lineLimit(1).foregroundColor(Color(.lightGray))
                            
                        
                        
                    }.frame(maxWidth: 70)

                }.padding(10).background(Color(.white)).cornerRadius(15).shadow(radius: 0).padding(1)
            }.buttonStyle(PlainButtonStyle())
             
        }
         
    
}





