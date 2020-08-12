//
//  BudgetDetailCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetDetailCard: View {
    
    var budgetCategory : BudgetCategory
    var spendingCategory : SpendingCategory
    var parentService : BalanceParentService
    @ObservedObject var service : CategoryEditService
    
    init(budgetCategory: BudgetCategory, parentService: BalanceParentService){
        self.budgetCategory = budgetCategory
        self.spendingCategory = budgetCategory.spendingCategory!
        self.parentService = parentService
        self.service = CategoryEditService(budgetCategory: budgetCategory, parentService: parentService)
    }
    
    var spentChip : some View{
        
        Text("$" + String(Int(self.spendingCategory.initialThirtyDaysSpent)) + " previsouly spent").foregroundColor(Color(.white)).padding(5).padding(.horizontal, 5).background(Color(AppTheme().themeColorPrimaryUIKit.lighter(by: 30)!)).cornerRadius(15).padding(.leading)
        
    }
    
    var deleteButton: some View{
        
        Button(action: {
            self.parentService.deleteCategory(id: self.budgetCategory.id!)
        }) {
            Image(systemName: "multiply.circle.fill").foregroundColor(Color(.lightGray)).imageScale(.large)
        }.buttonStyle(PlainButtonStyle())
        
    }
    
    var card: some View{
        VStack{
            HStack{
                Text(self.spendingCategory.icon!).font(.headline)
                Text(self.spendingCategory.name!).font(.system(size: 15)).foregroundColor(Color(.gray)).fontWeight(.light)
                Spacer()
                deleteButton
            }.padding(.horizontal).padding(.top, 15)
                   
                    
     
            
            if self.spendingCategory.initialThirtyDaysSpent > 0.0 {
                
                HStack{
                    CustomInputTextField(text: self.$service.editText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.service, key: self.spendingCategory.name!).id(self.spendingCategory.id!).padding(.horizontal, 10).padding(.vertical, 5).background(Color(.systemGroupedBackground)).cornerRadius(10).frame(width: 95).padding(.horizontal)
                    Spacer()
                }.padding(.leading).padding(.vertical, 5)
                
                Divider()
                
                HStack{
                    
                    spentChip
                    
                    Spacer()
                    Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold()).padding(.trailing)
                }.padding(.bottom, 10)
            }
            else{
                
                HStack{
                    Button(action: {
                        
                    }) {
                        CustomInputTextField(text: self.$service.editText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 20), alignment: .left, delegate: self.service, key: self.spendingCategory.name!).id(self.spendingCategory.id!).padding(.horizontal, 10).padding(.vertical, 5).background(Color(.systemGroupedBackground)).cornerRadius(10).frame(width: 95).padding(.horizontal)
                        Spacer()
                    }.buttonStyle(BorderlessButtonStyle())
                       
                        
                }.padding(.leading).padding(.vertical, 5).padding(.bottom)
                
            }
            
            
                   
                   
            }.background(Color(.white)).cornerRadius(15).shadow(radius: 3)
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
