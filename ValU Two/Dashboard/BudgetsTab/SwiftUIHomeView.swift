//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI
import SwiftKeychainWrapper

struct BudgetsView: View {
    
    var viewModel: BudgetsViewModel
    @ObservedObject var budget: Budget
    @ObservedObject var fixNowService : FixNowService

    
    init(viewModel: BudgetsViewModel, budget: Budget){
        self.viewModel = viewModel
        self.budget = budget
        self.fixNowService = FixNowService(coordinator: self.viewModel.coordinator!)
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        let fontSize: CGFloat = 35

        // Here we get San Francisco with the desired weight
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)

        // Will be SF Compact or standard SF in case of failure.
        let font: UIFont

        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: fontSize)
        } else {
            font = systemFont
        }
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : font]
        
       
        
        
        
        print("home init")
    }
    

    
    var fixNowCards: some View{
        
        ForEach(self.fixNowService.exiredItemIds, id: \.self){ expiredId in
            FixNowCard(service: self.fixNowService, itemId: expiredId).padding(.horizontal)
        }
    }
    

    
    
    

    

    
    var body: some View {
        
            ScrollView{
                
                fixNowCards
                
                
                TimeSectionView(budget: self.viewModel.currentBudget, service: self.viewModel.budgetTransactionsService, coordinator: self.viewModel.coordinator).padding(5).padding(.top, 5)
                
                    
                    
                    //self.topButtons//.padding(.top, 7)
                    
                Divider().padding(.leading)
                
                            
                            //self.budgetHeader.padding(.bottom,5)
                            
                BudgetCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel).padding(5)
                            
                            
                            
                            //IncomeSectionView(coordinator: self.viewModel.coordinator, service: self.viewModel.budgetTransactionsService).padding(.top, 10).padding(.horizontal)
                            
                        
                
                Divider().padding(.leading)
                
                
                

                
                IncomeSectionView(coordinator: self.viewModel.coordinator, service: self.viewModel.budgetTransactionsService, budget: self.budget).padding(5)
                
                
                Divider().padding(.leading)

                
                SpendingCardView(budget: self.viewModel.currentBudget, viewModel: self.viewModel.spendingModel!).padding(.horizontal).padding(.bottom).padding(.top, 5)
        
            

            }
        
 
        
            
                  
            .navigationBarTitle("This Month").navigationBarItems(
            
            leading: Button(action: {
                self.viewModel.coordinator!.editClicked(budgetToEdit: self.viewModel.currentBudget)
            }){
                NavigationBarTextButton(text: "Edit")
                }
                                                                   
                                                                   
                , trailing: Button(action: {
                    self.viewModel.clickedSettingsButton()
                }){
                
                    CircleButtonIcon(icon: "gear", color: AppTheme().themeColorPrimary)
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
