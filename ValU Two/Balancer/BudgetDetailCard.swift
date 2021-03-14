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
    var coordinator: BudgetEditableCoordinator
    @ObservedObject var service : CategoryEditService
    
    var historicalTransactions : HistoricalTransactionsViewModel
    
    var color : Color
    
    var viewModel : BudgetBalancerPresentor
    
    
    @State var test = "test"
     
    
    init(budgetCategory: BudgetCategory, coordinator: BudgetEditableCoordinator, viewModel: BudgetBalancerPresentor, color: Color){
        self.coordinator = coordinator
        self.budgetCategory = budgetCategory
        self.viewModel = viewModel
        self.spendingCategory = budgetCategory.spendingCategory!
        self.color = color
        self.service = CategoryEditService(budgetCategory: budgetCategory, viewModel: self.viewModel)
        self.historicalTransactions = HistoricalTransactionsViewModel(category: budgetCategory)
    }

    
    var deleteButton: some View{
        
        Menu {
            Button(action: {
                self.viewModel.deleteCategory(id: self.budgetCategory.id!, budgetSection: self.budgetCategory.budgetSection!)
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
            CircleButtonIcon(icon: "ellipsis", color: self.color, circleSize: 27, fontSize: 13)
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
            HStack{
                
                
                Text(historicalTransactions.getDisplayText()).font(.system(size: 15, design: .rounded)).foregroundColor(self.color).bold().padding(.leading)
                
                Spacer()
                Image(systemName: "chevron.right").foregroundColor(self.color).font(Font.system(.headline).bold()).padding(.trailing)
            }.padding(.vertical, 10)
        }.background(self.color.opacity(0.2))
        
        
    }
    
    
    var card: some View{
        VStack(spacing: 0){
            HStack{
                Text(self.spendingCategory.icon!).font(.system(size: 17))
                Text(self.spendingCategory.name!).font(.system(size: 17, design: .rounded)).fontWeight(.semibold).lineLimit(1)
                Spacer()
                deleteButton
            }.padding(.horizontal, 13).padding(.top, 10)
                   
                    
     
            
                
                HStack{
                    CustomInputTextField(text: self.$service.editText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.service, key: self.spendingCategory.name!).id(self.spendingCategory.id!).padding(.horizontal).padding(.trailing)
                    Spacer()
                }.padding(.leading).padding(.top, 10).padding(.vertical, 5).padding(.bottom)
                
                
                
                
                if self.historicalTransactions.getPreviouslySpent() > 0.0 {
                
                Button(action: {
                    self.coordinator.showHistoricalTransactions(budgetCategory: self.budgetCategory, model: self.historicalTransactions)
                }) {
                    
                    self.pill
                    
                }.buttonStyle(BorderlessButtonStyle())
                }
                
            
            
                
            
                   
                   
        }.background(Color(.tertiarySystemBackground)).cornerRadius(18).shadow(radius: 8)
    }
    
    
    var body: some View {
        card
    }
}


extension UIColor {

    func lighter(by percentage: CGFloat = 7.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }

    func darker(by percentage: CGFloat = 7.0) -> UIColor? {
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
