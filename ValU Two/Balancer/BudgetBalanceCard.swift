//
//  BudgetBalanceCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetBalanceCard: View {
    
    @ObservedObject var budgetSection : BudgetSection
    var coordinator : SetSpendingLimitDelegate
    var viewModel : BudgetBalancerPresentor
    
    var color : Color
    var colorSeconday : Color
    var colorTertiary : Color
    
    @State var showingDeleteAlert = false
    
    init(budgetSection: BudgetSection, coordinator: SetSpendingLimitDelegate, viewModel: BudgetBalancerPresentor){
        self.budgetSection = budgetSection
        self.coordinator = coordinator
        self.viewModel = viewModel
        
        self.color = colorMap[Int(budgetSection.colorCode)]
        self.colorSeconday = Color(colorMapUIKit[Int(budgetSection.colorCode)].lighter()!)
        self.colorTertiary = Color(colorMapUIKit[Int(budgetSection.colorCode)].darker()!)
    }
    
    
    
    var card : some View{
        
        

            HStack{
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon ?? "calendar", size: CGFloat(45))
                
                HStack(){
                    //Text(self.icon).font(.system(size: 22)).bold()
                    Text(self.budgetSection.name ?? "unknown").font(.system(size: 18, design: .rounded)).bold().foregroundColor(Color(.white)).lineLimit(1)
                    Spacer()

                }

                    Spacer()
                
                           
                Text(CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit()))).font(.system(size: 21, design: .rounded)).foregroundColor(Color(.white)).bold()
                Image(systemName: "chevron.right").foregroundColor(Color(.white)).font(Font.system(.headline).bold()).padding(.leading, 5).padding(.trailing, 5)
            }.padding(11).background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(20).shadow(radius: 0)
                
        
    }
    
    var row: some View{
        HStack{
            BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon ?? "calendar", size: 43)
            Text(self.budgetSection.name ?? "unknown").font(.system(size: 17, design: .rounded)).bold().foregroundColor(colorMap[Int(self.budgetSection.colorCode)]).lineLimit(1)
            Spacer()
            Text(CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit()))).foregroundColor(colorMap[Int(self.budgetSection.colorCode)]).font(.system(size: 23, design: .rounded)).fontWeight(.bold)
            Image(systemName: "chevron.right").font(.system(size: 15, design: .rounded)).foregroundColor(colorMap[Int(self.budgetSection.colorCode)])
        }.padding(.horizontal).padding(.vertical, 10).background(Color(.tertiarySystemBackground)).cornerRadius(21)
    }
    
    
    var cardGrid: some View{
        VStack(alignment: .leading){
            
            HStack(alignment: .top){
                BudgetSectionIconLarge(color: colorMap[Int(self.budgetSection.colorCode)], icon: self.budgetSection.icon ?? "calendar", size: 40)
                Spacer()
                
                Button(action: {
                    // What to perform
                    self.showingDeleteAlert.toggle()
                    print("delete budget section")
                }) {
                    // How the button looks like
                    CircleButtonIcon(icon: "x.circle.fill", color: Color(.white), circleSize: 0, fontSize: 18)
                }.buttonStyle(PlainButtonStyle())
                    
                
                
            }.padding(.bottom, 15)
            
            HStack{
                Text(self.budgetSection.name ?? "unknown").font(.system(size: 15, design: .rounded)).bold().foregroundColor(.white).lineLimit(1)
                Spacer()
                
            }
            
            Text(CommonUtils.makeMoneyString(number: Int(self.budgetSection.getLimit()))).foregroundColor(Color(.white)).font(.system(size: 23, design: .rounded)).fontWeight(.bold)
            
        }.padding(12)
        
        .background(LinearGradient(gradient: Gradient(colors: [self.colorSeconday, self.color]), startPoint: .top, endPoint: .bottom)).cornerRadius(23)
    }
    
    
    var body: some View {
        
        Button(action: {
            self.coordinator.showCategoryDetail(budgetSection: self.budgetSection, viewModel: self.viewModel)
        }) {
            //self.cardGrid
            self.cardGrid
        }.buttonStyle(PlainButtonStyle())
            .alert(isPresented:self.$showingDeleteAlert) {
                Alert(title: Text("Are you sure you want to delete this budget?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                    self.viewModel.deleteBudgetSection(section: self.budgetSection)
                }, secondaryButton: .cancel())
            }
    }
}
