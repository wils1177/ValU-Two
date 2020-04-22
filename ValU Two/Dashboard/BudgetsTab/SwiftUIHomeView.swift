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
    var pickerOptions = ["Current" ,"Past", "Future"]
    @State var currentSelected = 0
    
    
    init(viewModel: BudgetsViewModel){
        self.viewModel = viewModel
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        
    }
    
    var picker: some View{
        Picker("", selection: self.$currentSelected) {
                Text(self.pickerOptions[0]).tag(0)
                Text(self.pickerOptions[1]).tag(1)
                Text(self.pickerOptions[2]).tag(2)
        }.pickerStyle(SegmentedPickerStyle())
    }
    

    
    var topButtons: some View{
        HStack{
            pastButton.padding(.trailing, 10)
            futureButton.padding(.leading, 10)
        }.padding(.horizontal, 13)
    }
    
    var futureButton: some View{
            
            Button(action: {
                self.viewModel.coordinator?.showFutureBudgets(futureTimeFrames: self.viewModel.futureBudgets, viewModel: self.viewModel)
            }) {
                HStack{
                    HStack{
                        Spacer()
                        Image(systemName: "clock.fill").imageScale(.large)
                        Text("Future").font(.headline).bold()
                        Spacer()
                    }.padding(.vertical, 10)
                    
                }.background(Color(.white)).cornerRadius(10).shadow(radius: 2)
            }.buttonStyle(PlainButtonStyle())
            
            
        
    }
    
    var pastButton: some View{
            
            Button(action: {
                self.viewModel.coordinator?.showPastBudgets(pastTimeFrames: self.viewModel.historicalBudgets, viewModel: self.viewModel)
            }) {
                HStack{
                    HStack{
                        Spacer()
                        Image(systemName: "bookmark")
                        Text("Past").font(.headline).bold()
                        Spacer()
                    }.padding(.vertical, 10)
                    
                    }.background(Color(.white)).cornerRadius(10).shadow(radius: 2)
            }.buttonStyle(PlainButtonStyle())
            
            
        
    }
    
    var BudgetSectionTitle  : some View{
        HStack{
            SectionTitleView(title: "April")
            Spacer()
            EditBudgetButton(budget: self.viewModel.currentBudget!, coordinator: self.viewModel.coordinator!)
        }
    }
    

    
    var body: some View {
        
        
        

            
            List{
                self.topButtons.padding(.vertical)
                
                BudgetCardView(budget: self.viewModel.currentBudget!, viewModel: self.viewModel).background(Color(.white)).cornerRadius(15).padding(.vertical, 5).padding().shadow(radius: 10)

                
                IncomeSectionView(budget: self.viewModel.currentBudget!, coordinator: self.viewModel.coordinator).padding()

                


                SpendingCardView(budget: self.viewModel.currentBudget!, viewModel: self.viewModel.spendingModel!, coordinator: self.viewModel.coordinator!).padding()
                


            }
                  

            
            
        

        
            

         
        .navigationBarTitle("Budgets").navigationBarItems(
                                                                   
                                                                   
                trailing: Button(action: {
                    self.viewModel.clickedSettingsButton()
                }){
                ZStack{
                    
                    Image(systemName: "person.crop.circle").imageScale(.large)
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
