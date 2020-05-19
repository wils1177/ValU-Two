//
//  BalancerBodyView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BalancerBodyView: View {
    
    @ObservedObject var viewModel : BudgetBalancerPresentor
      
      init(viewModel: BudgetBalancerPresentor){
          
          self.viewModel = viewModel
          // To remove only extra separators below the list:
          UITableView.appearance().tableFooterView = UIView()

          // To remove all separators including the actual ones:
          UITableView.appearance().separatorStyle = .none
        
      }

    
      
      var body: some View {
        
            
            List{
                     
                VStack{
                    SpendingLimitSummaryView(viewModel: self.viewModel).cornerRadius(15)
                    
                    
                    HStack{
                        Text("Budgets").font(.system(size: 22)).bold()
                        Spacer()
                    }.padding(.top, 10).padding(.horizontal)
                    
                    
                    ForEach(self.viewModel.parentServices, id: \.self) { service in
                        VStack(spacing: 0){
                            
                            BudgetBalanceCard(service: service, spendingCategory: service.parent, coordinator: self.viewModel.coordinator!).padding(.bottom, 5)
     
                        }
                    }
                    
                }
  
                
            }

    }
           
      
}


