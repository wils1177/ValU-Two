//
//  BudgetCategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/16/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetCategoryDetailView: View {
    
    var coordinator : BudgetsTabCoordinator
    
    @ObservedObject var category: BudgetCategory
    
    var detailModel = BudgetDetailViewModel()
    
    init(category: BudgetCategory, coordinator: BudgetsTabCoordinator){
        self.coordinator = coordinator
        self.category = category
    }
    
    var left : Double{
        return category.limit - category.getAmountSpent()
    }
    
    func getLeft() -> String{
        return CommonUtils.makeMoneyString(number: Int(left))
    }
    
    func getText() -> String{
        if left >= 0{
            return "Left in Budget"
        }
        else{
            return "Over Budget"
        }
    }
    
    var graphTitle : String {
        return category.spendingCategory!.icon! + " " + category.spendingCategory!.name! + " " + "Spending"
    }
    
    var body: some View {
        List{
            VStack(spacing: 5){
                
                HStack{
                    VStack(alignment: .leading){
                        Text(getText()).foregroundColor(Color(.gray)).font(.system(size: 16, weight: .bold, design: .rounded))
                        Text(getLeft()).font(.system(size: 30, design: .rounded)).foregroundColor(colorMap[Int(category.budgetSection!.colorCode)]).fontWeight(.bold)
                    }//.padding(.bottom)
                    Spacer()
                }.padding(5)
                
                
                    
                    
                    
                    
                    VStack{
                        
                        HStack{
                            Text(graphTitle).font(.system(size: 21, design: .rounded)).fontWeight(.bold)
                            Spacer()
                        }.padding(.bottom)
                        
                        //LineView(dataSet1: self.detailModel.getThisMonthTransactionsForCategory(category: self.category), dataSet2: self.detailModel.getLastMonthTransactionsForCategory(category: self.category), cutOffValue: Double(self.category.limit), color1: colorMap[Int(category.budgetSection!.colorCode)], color2: Color(.lightGray).opacity(0.7), cutOffColor: colorMap[Int(category.budgetSection!.colorCode)], legendSet: self.detailModel.getGraphLabels(category: self.category)).frame(height: 200).padding(.bottom, 15)
                        
                        NewLineGraph(dataSet1: self.detailModel.getThisMonthTransactionsForCategory(category: self.category), color1: colorMap[Int(category.budgetSection!.colorCode)], dataSet2: self.detailModel.getLastMonthTransactionsForCategory(category: self.category), color2: Color(.lightGray).opacity(0.7), cutOffValue:  Double(self.category.limit), cutOffColor: colorMap[Int(category.budgetSection!.colorCode)])
                    
                    HStack(spacing: 3){
                        Spacer()
                        Rectangle().frame(width: 25, height: 4).foregroundColor(colorMap[Int(category.budgetSection!.colorCode)])
                        Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                        Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                        Line()
                            .stroke(colorMap[Int(category.budgetSection!.colorCode)], style: StrokeStyle(lineWidth: 2, dash: [4]))
                                   .frame(width:25, height: 2)
                        Text("Budget").font(.system(size: 13, weight: .semibold))
                        Spacer()
                    
                        
                    }
                    
                    
                }.padding(12).background(Color(.tertiarySystemBackground)).cornerRadius(12)
                
            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear)
            
            Section(header: Text("Merchants").font(.system(size: 15, weight: .semibold, design: .rounded))){
                
                CategoryDetailTransactionsSection(category: category, coordinator: self.coordinator)
            }
        }.navigationTitle(category.spendingCategory!.name!)
            .navigationBarItems(
                trailing: Button(action: {
                    self.coordinator.showEditBudgetSectionIndividually(section: self.category.budgetSection!)
                }){
                
                    NavigationBarTextButton(text: "Edit", color: colorMap[Int(category.budgetSection!.colorCode)])
        })
    }
}


