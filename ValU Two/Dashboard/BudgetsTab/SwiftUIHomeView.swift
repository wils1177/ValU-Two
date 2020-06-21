//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetsView: View {
    
    var viewModel: BudgetsViewModel
    @ObservedObject var fixNowService : FixNowService

    
    init(viewModel: BudgetsViewModel){
        self.viewModel = viewModel
        
        self.fixNowService = FixNowService(coordinator: self.viewModel.coordinator)
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        UITableViewCell.appearance().backgroundColor = .systemGroupedBackground
        UITableView.appearance().backgroundColor = .systemGroupedBackground
        print("home init")
    }
    
    func getDaysRemaining() -> String{
        
        let today = Date()
        let endDate = self.viewModel.currentBudget.endDate!
        
        let diffInDays = Calendar.current.dateComponents([.day], from: today, to: endDate).day
        
        return String(diffInDays!) + " DAYS LEFT"
        
    }
    
    func getDateString() -> String{
        let today = Date()
        let monthName = CommonUtils.getMonthFromDate(date: today)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        let day = formatter.string(from: today)
        
        return monthName + " " + day
    }
    
    var fixNowCards: some View{
        
        ForEach(self.fixNowService.exiredItemIds, id: \.self){ expiredId in
            FixNowCard(service: self.fixNowService, itemId: expiredId)
        }
    }
    

    
    var body: some View {
 
            List{
                
                fixNowCards
                
                //self.topButtons//.padding(.top, 7)
            
                VStack(spacing: 0){
                    HStack(spacing:5){
                        HStack{
                            Text(getDateString()).font(.system(size: 22)).foregroundColor(Color(.black)).fontWeight(.semibold)

                        }.padding(.leading)

                        Spacer()
                        HStack{
                            //Image(systemName: "clock.fill").foregroundColor(Color(.lightGray))
                            Text(self.getDaysRemaining()).foregroundColor(Color(.white)).font(.footnote).bold().padding(4).padding(.horizontal, 10).background(Color(.lightGray)).cornerRadius(20)
                        }.padding(.trailing, 10)
                    }.padding(.horizontal, 10)
                    Divider().padding(.top, 10).padding(.leading).padding(.leading)
                }.listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).padding(.bottom).padding(.top, 10)
                

                
                
                
                
                    //Text("$" + String(self.viewModel.totalSpending)).font(.headline).fontWeight(.bold)
            
                
                
                Button(action: {
                    self.viewModel.coordinator.editClicked(budgetToEdit: self.viewModel.currentBudget)
                }) {
                    BudgetCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel).background(AppTheme().themeColorPrimary).cornerRadius(20).padding(.horizontal, 5).shadow(radius: 5)
                    //testBudgetSummary.background(Color(.systemBlue)).cornerRadius(20).padding(.horizontal, 5).shadow(radius: 4).padding(.top, 5)
                }.buttonStyle(PlainButtonStyle())
                
                
                
                
                IncomeSectionView(budget: self.viewModel.currentBudget, coordinator: self.viewModel.coordinator).padding(.top, 10)
                

                    HStack(spacing: 0){
                        Text("Categories").font(.system(size: 22)).bold()
                        Spacer()
                        
                        Button(action: {
                            // What to perform
                            self.viewModel.coordinator.continueToBudgetCategories()
                        }) {
                            // How the button looks like
                            Text("Edit").font(.callout).foregroundColor(AppTheme().themeColorPrimary).padding(.trailing)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }.padding(.horizontal, 15).padding(.top, 10)
                
                    
                


                SpendingCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel.spendingModel!, coordinator: self.viewModel.coordinator)
                


            }
                  

        .navigationBarTitle("Budget").navigationBarItems(
                                                                   
                                                                   
                trailing: Button(action: {
                    self.viewModel.clickedSettingsButton()
                }){
                ZStack{
                    
                    Image(systemName: "gear").imageScale(.large)
                }
        })
           
        
        
    }
}
/*
struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}
*/
