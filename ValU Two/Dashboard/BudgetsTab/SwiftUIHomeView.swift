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
    
    var budgetHeader : some View{
        
        HStack(spacing: 7){
            
            HStack{
                Text("AUGUST BUDGET").font(.system(size: 18)).foregroundColor(Color(.black)).fontWeight(.semibold)
                Spacer()
            }.padding(.leading)
            
            Spacer()
                    
            HStack{
                Image(systemName: "calendar").foregroundColor(Color(.white))
                Text(self.getDaysRemaining()).foregroundColor(Color(.white)).font(.subheadline).bold()
            }.padding(4).padding(.horizontal, 10)//.background(AppTheme().themeColorPrimary).cornerRadius(20).padding(.trailing)

                


                
                
                
            
            //Divider().padding(.top, 10).padding(.leading).padding(.leading)
        }.padding(.bottom, 5)
        
    }
    
    var categoriesHeader: some View{
        HStack(spacing: 0){
            Image(systemName: "creditcard").foregroundColor(AppTheme().themeColorPrimary).font(.system(size: 18))
            Text(" Budgets").font(.system(size: 18)).fontWeight(.medium)
            Spacer()
            
            
            
        }.padding(.horizontal, 15)
    }
    

    

    
    var body: some View {
        
            ScrollView{
                
                HStack{
                    Image(systemName: "calendar").foregroundColor(Color(.gray)).font(.system(size: 17))
                    Text("17 Days Left In Budget").foregroundColor(Color(.gray)).font(.system(size: 16)).bold()
                    Spacer()
                }.padding(.horizontal).offset(x: 0, y: -5)
                    
                    //fixNowCards
                    
                    //self.topButtons//.padding(.top, 7)
                    
                Divider().padding(.leading)
                
                        
                            
                        HStack(spacing:2){
                                Image(systemName: "arrow.down.app").font(.system(size: 18)).foregroundColor(AppTheme().themeColorPrimary)
                                Text("Spending").font(.system(size: 18)).fontWeight(.medium).foregroundColor(Color(.black))
                                Spacer()
                            }.padding(.horizontal, 15).padding(.top ,5)
                            
                            //self.budgetHeader.padding(.bottom,5)
                            
                            BudgetCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel).padding(5).padding(.top, 5)
                            
                            
                            
                            //IncomeSectionView(coordinator: self.viewModel.coordinator, service: self.viewModel.budgetTransactionsService).padding(.top, 10).padding(.horizontal)
                            
                        
                
                Divider().padding(.leading)

                    

                self.categoriesHeader.padding(.leading, 5).padding(.top ,5)
                SpendingCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel.spendingModel!, coordinator: self.viewModel.coordinator).padding(.horizontal).padding(.bottom)
        
            

            }
        
 
        
            
                  

            .navigationBarTitle("Summary").navigationBarItems(
            
            leading: Button(action: {
                self.viewModel.coordinator.editClicked(budgetToEdit: self.viewModel.currentBudget)
            }){
                ZStack(alignment:.center){
                    Circle().frame(width: 30, height: 30, alignment: .center).foregroundColor(AppTheme().themeColorSecondary)
                    Image(systemName: "pencil").font(Font.system(size: 15, weight: .bold)).foregroundColor(AppTheme().themeColorPrimary)
            }
                }
                                                                   
                                                                   
                , trailing: Button(action: {
                    self.viewModel.clickedSettingsButton()
                }){
                ZStack(alignment:.center){
                    Circle().frame(width: 30, height: 30, alignment: .center).foregroundColor(AppTheme().themeColorSecondary)
                    Image(systemName: "gear").font(Font.system(size: 15, weight: .bold)).foregroundColor(AppTheme().themeColorPrimary)
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
