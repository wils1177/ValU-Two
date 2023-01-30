//
//  HistoryTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct HistoryTabView: View {
    
    @ObservedObject var viewModel : HistoryViewModel
    @State var showStatsView = true
    
    @State private var selection = 0
    
   
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
    
    }
    
    
        
    func changeToSection(section: BudgetSection){
        
    }
    
    func changeToAll(){
        
    }
    
    func changeToOther(){
        
    }
    
    
    
    var body: some View {
        List{
            
            
            
            
            HistoryGraphView(viewModel: self.viewModel)
            

                
            PastBudgetsView(viewModel: self.viewModel)
                
            
            
            
            
            
            
            /*
            HStack{
                Spacer()
                Button(action: {
                    // What to perform
                    self.viewModel.testBudgetCopy()
                }) {
                    // How the button looks like
                    Text("Test Budget Copy")
                }
                Spacer()
            }
            */
            
            
        }
        .background(Color(.systemGroupedBackground))
        
        .navigationBarTitle("History")
    }
}


