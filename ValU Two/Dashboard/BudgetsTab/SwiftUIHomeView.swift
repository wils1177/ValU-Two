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
        
        
        UITableViewCell.appearance().backgroundColor = .systemGroupedBackground
        UITableView.appearance().backgroundColor = .systemGroupedBackground
        
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
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "clock.fill").imageScale(.large)
                        Text("Future").font(.headline).bold().lineLimit(1)
                        Spacer()
                    }

                    
                }.padding(.vertical, 10).padding(.horizontal, 5).background(Color(.white)).cornerRadius(12)
            }.buttonStyle(PlainButtonStyle())
            
            
        
    }
    
    var pastButton: some View{
            
            Button(action: {
                self.viewModel.coordinator?.showPastBudgets(pastTimeFrames: self.viewModel.historicalBudgets, viewModel: self.viewModel)
            }) {
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "bookmark").imageScale(.large)
                        Text("History").font(.headline).bold().lineLimit(1)
                        Spacer()
                    }

                    
                }.padding(.vertical, 10).padding(.horizontal, 5).background(Color(.white)).cornerRadius(12)
            }.buttonStyle(PlainButtonStyle())
            
            
        
    }
    
    var BudgetSectionTitle  : some View{
        HStack{
            SectionTitleView(title: "April")
            Spacer()
            EditBudgetButton(budget: self.viewModel.currentBudget!, coordinator: self.viewModel.coordinator!)
        }
    }
    

    
    
    var incomeVSExpenses : some View{
        HStack{
            Spacer()
            HStack{
                Image(systemName: "chevron.up.circle.fill").foregroundColor(Color(.systemGreen)).imageScale(.large)
                VStack(alignment: .leading){
                    Text("Income").foregroundColor(Color(.lightGray)).bold()
                    Text("$3,454").font(.title).bold().lineLimit(1)
                }
            }.padding(.trailing, 7)
            Spacer()
            Divider()
            Spacer()
            HStack{
                Image(systemName: "chevron.down.circle.fill").foregroundColor(Color(.systemRed)).imageScale(.large)
                VStack(alignment: .leading){
                    Text("Expenses").foregroundColor(Color(.lightGray)).bold()
                    Text("$1,454").font(.title).bold().lineLimit(1)
                }
            }.padding(.leading, 7)
            Spacer()
        }
    }
    
    var incomeVSExpensesRoom : some View{
        
        VStack{
            HStack{
                Image(systemName: "chevron.up.circle.fill").foregroundColor(Color(.lightGray))
                Text("Cash Flow").foregroundColor(Color(.lightGray)).bold()
                Spacer()
            }.padding(.horizontal).padding(.top)
            HStack{
                Spacer()
                    
                VStack(alignment: .center, spacing: 5){
                        Text("$3,454").font(.title).bold().lineLimit(1)
                        HStack{
                            Circle().frame(width: 9, height: 9).foregroundColor(Color(.systemGreen)).imageScale(.medium)
                            Text("Earned").foregroundColor(Color(.systemGreen)).bold()
                        }
                        
                        
                    }
                
                Spacer()
                Divider()
                Spacer()
                    
                    VStack(alignment: .center, spacing: 5){
                        Text("$1,454").font(.title).bold().lineLimit(1)
                        HStack{
                            Circle().frame(width: 9, height: 9).foregroundColor(Color(.systemRed)).imageScale(.medium)
                            Text("Spent").foregroundColor(Color(.systemRed)).bold()
                        }
                        
                        
                    }

                Spacer()
            }
        }.padding(.bottom, 20)
        
        
    }
    
    
    var testBudgetSummary : some View{
        VStack(spacing: 5){
            VStack(spacing: 5){
                HStack{
                    Image(systemName: "clock.fill").foregroundColor(Color(.white)).imageScale(.medium)
                    Text("Budget").foregroundColor(Color(.white)).font(.headline).bold()
                    Spacer()
                    
                }.padding(.top)//.padding(.bottom ,10)
                //HStack{
                //    Text("24 Days left").foregroundColor(Color(.lightText)).font(.caption).bold().padding(.leading, 5)
                 //   Spacer()
                //}
                
            }.padding(.horizontal)
            
                
                HStack(alignment: .bottom, spacing: 0){
                    Text("$").foregroundColor(Color(.lightText)).font(.title).bold().padding(.bottom, 5)
                    Text("3,403").foregroundColor(Color(.white)).font(.system(size: 45)).bold()
                    Text(" / 5000").foregroundColor(Color(.lightText)).foregroundColor(Color(.lightGray)).bold().padding(.bottom, 7)
                    Spacer()
                }.padding(.horizontal).padding(.leading, 10).padding(.top, 10)
                

                
              ZStack(alignment: .leading){
                  
                  RoundedRectangle(cornerRadius: 10).frame(width: 285, height: 25).foregroundColor(Color(.lightText))
                  
                  RoundedRectangle(cornerRadius: 10).frame(width: 130, height: 25).foregroundColor(Color(.white))
                  //Text("April").foregroundColor(Color(.white)).bold().padding(.leading)
                  //RoundedRectangle(cornerRadius: 5).frame(width: 70, height: 30).foregroundColor(Color(.systemOrange))
                  //RoundedRectangle(cornerRadius: 5).frame(width: 20, height: 30).foregroundColor(Color(.systemRed))
                  //RoundedRectangle(cornerRadius: 5).frame(width: 30, height: 30).foregroundColor(Color(.systemBlue))
                  Text("Remaining").foregroundColor(Color(.systemBlue)).bold().padding(.leading, 10)
              }.padding(.bottom, 20).padding(.horizontal).padding(.vertical, 7).padding(.top, 7)
            

            
                
            
        }
    }

    
    var body: some View {
        
        
        

            
            List{
                
                
                
                
                //self.topButtons//.padding(.top, 7)
            
                /*
                VStack(spacing:0){
                    HStack{
                        Text("Saterday, May 24th").font(.system(size: 26)).bold()
                        Spacer()
                        Image(systemName: "ellipsis.circle.fill").imageScale(.large).padding(.trailing)
                    }
                        
                    HStack{
                        Image(systemName: "clock.fill").foregroundColor(Color(.lightGray))
                        Text("24 Days Left").foregroundColor(Color(.lightGray)).font(.callout).bold()
                        Spacer()
                    }
                }.padding(.horizontal).padding(.bottom, 10)
                */
                    //Text("$" + String(self.viewModel.totalSpending)).font(.headline).fontWeight(.bold)
            
                
                
                Button(action: {
                    self.viewModel.coordinator?.editClicked(budgetToEdit: self.viewModel.currentBudget!)
                }) {
                    BudgetCardView(budget: self.viewModel.currentBudget!, viewModel: self.viewModel).background(Color(.systemTeal)).cornerRadius(20).padding(.horizontal, 5).shadow(radius: 5)
                    //testBudgetSummary.background(Color(.systemBlue)).cornerRadius(20).padding(.horizontal, 5).shadow(radius: 4).padding(.top, 5)
                }.buttonStyle(PlainButtonStyle()).padding(.top, 10)
                
                
                
                
                IncomeSectionView(budget: self.viewModel.currentBudget!, coordinator: self.viewModel.coordinator).padding(.top, 10)
                

                    HStack(spacing: 0){
                        Text("Budgets").font(.system(size: 22)).bold()
                        Spacer()
                        
                        Button(action: {
                            // What to perform
                            self.viewModel.coordinator?.continueToBudgetCategories()
                        }) {
                            // How the button looks like
                            Text("Edit").foregroundColor(Color(.white)).padding(8).background(AppTheme().themeColorPrimary).cornerRadius(20).padding(.trailing)
                        }.buttonStyle(PlainButtonStyle())
                        
                    }.padding(.horizontal, 10).padding(.top, 10)
                
                    
                


                SpendingCardView(budget: self.viewModel.currentBudget!, viewModel: self.viewModel.spendingModel!, coordinator: self.viewModel.coordinator!)
                


            }
                  

        .navigationBarTitle("Budget").navigationBarItems(
                                                                   
                                                                   
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
