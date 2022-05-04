//
//  CategoryDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryDetailView: View {
    
    var coordinator : BudgetsTabCoordinator
    
    @ObservedObject var section: BudgetSection
    
    var detailModel = BudgetDetailViewModel()
    
    init(section: BudgetSection, coordinator: BudgetsTabCoordinator){
        self.coordinator = coordinator
        self.section = section
    }
    
    var left : Double {
        return self.section.getLimit() - self.section.getSpent()
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
        return section.name! + " " + "Spending"
    }

    var body: some View {
        List{
            
        
                //DetailedParentCategoryCard(budgetSection: self.section).padding(.top).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear)//.shadow(radius: 15)
            VStack(spacing: 5){
                
                HStack{
                    
                    VStack(alignment: .leading){
                        Text(getText()).foregroundColor(Color(.gray)).font(.system(size: 16, weight: .bold, design: .rounded))
                        Text("\(CommonUtils.makeMoneyString(number: left))").font(.system(size: 30, design: .rounded)).foregroundColor(colorMap[Int(section.colorCode)]).fontWeight(.bold)
                    }//.padding(.bottom)
                    Spacer()
                }.padding(.top, 10)
                
                
                VStack{
                    
                    HStack{
                        Text(graphTitle).font(.system(size: 21, design: .rounded)).fontWeight(.bold)
                        Spacer()
                    }.padding(.bottom, 15)
                    
                    LineView(dataSet1: self.detailModel.getThisMonthTransactionsForSection(section: self.section), dataSet2: self.detailModel.getLastMonthTransactionsForSection(section: self.section), cutOffValue: Double(self.section.getLimit()), color1: colorMap[Int(section.colorCode)], color2: Color(.lightGray).opacity(0.7), cutOffColor: colorMap[Int(section.colorCode)], legendSet: self.detailModel.getGraphLabels(section: self.section)).frame(height: 200).padding(.bottom, 15)
                    
                
                HStack(spacing: 3){
                    Spacer()
                    Rectangle().frame(width: 25, height: 4).foregroundColor(colorMap[Int(section.colorCode)])
                    Text("This Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                    Rectangle().frame(width: 25, height: 4).foregroundColor(Color(.lightGray))
                    Text("Last Month").font(.system(size: 13, weight: .semibold)).padding(.trailing)
                    Line()
                        .stroke(colorMap[Int(section.colorCode)], style: StrokeStyle(lineWidth: 2, dash: [4]))
                               .frame(width:25, height: 2)
                    Text("Budget").font(.system(size: 13, weight: .semibold))
                    Spacer()
                }
                    
                }.padding(12).background(Color(.tertiarySystemBackground)).cornerRadius(21)
                
                
            }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear)
            
            Text("Merchants").font(.system(size: 23, weight: .semibold, design: .rounded)).listRowBackground(Color.clear).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).padding(.horizontal).padding(.top, 30)
                
            ForEach(self.section.getBudgetCategories(), id: \.self) { category in
                    
                Section(header: CategorySectionHeader(limit: category.limit, spent: category.getAmountSpent(), icon: category.spendingCategory!.icon!, name: category.spendingCategory!.name!, color: colorMap[Int(category.budgetSection!.colorCode)])){
                    
                    CategoryDetailTransactionsSection(category: category, coordinator: self.coordinator)
                }
                
                    
                    
            }
            
  
        }
        
        .navigationBarItems(
            trailing: Button(action: {
                self.coordinator.showEditBudgetSectionIndividually(section: self.section)
            }){
            
                NavigationBarTextButton(text: "Edit", color: colorMap[Int(section.colorCode)])
    })
            

        }
}

struct CategorySectionHeader: View{
    
    var limit : Double
    var spent : Double
    var icon : String
    var name : String
    var color: Color
    
    var body: some View{
        HStack(spacing: 5){
            
            Text(self.icon).font(.system(size: 21, design: .rounded)).bold().lineLimit(1)
            
            VStack(alignment: .leading){
                Text(self.name).font(.system(size: 16, design: .rounded)).bold().lineLimit(1)
                
            }
            
            
                
                Spacer()
            
            Text("\(Text(CommonUtils.makeMoneyString(number: spent)).font(.system(size: 16, design: .rounded)).foregroundColor(self.color).bold()) / \(Text(CommonUtils.makeMoneyString(number: limit)))").font(.system(size: 16, design: .rounded)).bold().foregroundColor(Color(.gray)).lineLimit(1)
                
            
                
            }
    }
    
}



