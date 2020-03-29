//
//  BudgetsTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct BudgetsTabView: View {
    
    @ObservedObject var viewModel : BudgetsTabViewModel
    
    func createSectionTitle(text: String) -> some View {
        return HStack{
            Text(text).font(.headline).bold().padding()
            Spacer()
        }
    }
    
    func historyZeroState() -> some View{
        return HStack{
            Text("Budgets will appear here after they're completed").foregroundColor(Color(.lightGray))
            Spacer()
        }.padding(.horizontal).padding(.bottom)
    }
    
    func getView(viewData: BudgetsListWrapper) ->  some View{
        
        if viewData.sectionTitle != nil{
            return AnyView(createSectionTitle(text: viewData.sectionTitle!))
        }
        if viewData.futureZero != nil{
            return AnyView(FutureBudgetEmptyState(viewModel : self.viewModel))
        }
        if viewData.historyZero != nil{
            return AnyView(historyZeroState())
        }
        if viewData.futureEntry != nil{
            return AnyView(FutureEntryView(viewData: viewData.futureEntry!, viewModel: self.viewModel))
        }
        if viewData.historyEntry != nil{
            return AnyView(HistoryEntryView(viewData : viewData.historyEntry!))
        }
        else{
            return AnyView(Text("An error occurred"))
        }
        
    }
    
    var body: some View {
        VStack{
            
            List(self.viewModel.viewData, id: \.self) { row in
                
                self.getView(viewData: row)
 
            }
        /*
            Button(action: {
                //Button Action
                self.viewModel.testBudgetCopy()
                }){
                HStack{
                    Spacer()
                    ZStack{
                        Text("Fake a New Budget").font(.subheadline).foregroundColor(.white).bold().padding()
                    }
                    Spacer()
                }.background(LinearGradient(gradient:  Gradient(colors: [.black, .black]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 10).padding()
                
                
            }
            */
        }.navigationBarTitle(Text("Budgets")).navigationBarItems(trailing: AddFutureBudgetButton(viewModel: self.viewModel, isSmall: true))
    }
}

