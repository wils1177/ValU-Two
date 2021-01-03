//
//  BudgetDetailCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetDetailCard: View {
    
    @ObservedObject var budgetCategory : BudgetCategory
    var spendingCategory : SpendingCategory
    var parentService : BalanceParentService
    var coordinator: BudgetEditableCoordinator
    @ObservedObject var service : CategoryEditService
    
    var historicalTransactions : HistoricalTransactionsViewModel
    
    var color : Color
    
    
    
    @State var test = "test"
     
    
    init(budgetCategory: BudgetCategory, parentService: BalanceParentService, coordinator: BudgetEditableCoordinator){
        self.coordinator = coordinator
        self.budgetCategory = budgetCategory
        self.spendingCategory = budgetCategory.spendingCategory!
        self.parentService = parentService
        self.color = colorMap[Int(spendingCategory.colorCode)]
        self.service = CategoryEditService(budgetCategory: budgetCategory, parentService: parentService)
        self.historicalTransactions = HistoricalTransactionsViewModel(category: budgetCategory)
    }

    
    var deleteButton: some View{
        
        Menu {
            Button(action: {
                self.parentService.deleteCategory(id: self.budgetCategory.id!)
            }) {
                Text("Remove Category").foregroundColor(Color(.red))
                Image(systemName: "x.circle").foregroundColor(Color(.placeholderText)).imageScale(.large)
            }.buttonStyle(PlainButtonStyle())
            
            Button(action: {
            
            }) {
                Text("Show Details")
                Image(systemName: "info.circle").foregroundColor(Color(.placeholderText)).imageScale(.large)
            }.buttonStyle(PlainButtonStyle())
        } label: {
            Image(systemName: "ellipsis.circle").foregroundColor(self.color).font(.title3)
        }
            
        
        
        
        
        /*
        Button(action: {
            self.parentService.deleteCategory(id: self.budgetCategory.id!)
        }) {
            Image(systemName: "multiply.circle.fill").foregroundColor(Color(.placeholderText)).imageScale(.large)
        }.buttonStyle(PlainButtonStyle())
        */
    }
    
    
    var pill : some View {
        
        VStack(){
            Divider()
            HStack{
                
                
                Text(historicalTransactions.getDisplayText()).foregroundColor(colorMap[Int(self.budgetCategory.budgetSection!.colorCode)]).bold().padding(.leading)
                
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold()).padding(.trailing)
            }.padding(.bottom, 10)
        }
        
        
    }
    
    
    var card: some View{
        VStack(spacing: 0){
            HStack{
                Text(self.spendingCategory.icon!).font(.headline)
                Text(self.spendingCategory.name!.uppercased()).font(.system(size: 12)).foregroundColor(Color(.gray)).fontWeight(.light)
                Spacer()
                deleteButton
            }.padding(.horizontal, 10).padding(.top, 10)
                   
                    
     
            
                
                HStack{
                    CustomInputTextField(text: self.$service.editText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.service, key: self.spendingCategory.name!).id(self.spendingCategory.id!).background(Color(.white)).padding(.horizontal).padding(.trailing)
                    Spacer()
                }.padding(.leading).padding(.top, 10).padding(.vertical, 5).padding(.bottom)
                
                
                
                
                if self.historicalTransactions.getPreviouslySpent() > 0.0 {
                
                Button(action: {
                    self.coordinator.showHistoricalTransactions(budgetCategory: self.budgetCategory, model: self.historicalTransactions)
                }) {
                    
                    self.pill
                    
                }.buttonStyle(BorderlessButtonStyle())
                }
                
            
            
                
            
                   
                   
            }.background(Color(.white)).cornerRadius(15).shadow(radius: 5)
    }
    
    
    var body: some View {
        card
    }
}


extension UIColor {

    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
