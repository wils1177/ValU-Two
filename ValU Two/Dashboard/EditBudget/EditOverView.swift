//
//  EditOverView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditOverView: View {
    
    var viewModel : BudgetEditor
    
    var income: some View{
        HStack{
            
            Image(systemName: "pencil.circle.fill").resizable()
                .frame(width: 30.0, height: 30.0).foregroundColor(Color(.systemGreen)).padding(.leading)
            
            VStack(spacing: 0){
                
                HStack{
                    Text("Income").font(.system(size: 17)).foregroundColor(.black).bold().padding(.leading).padding(.top).padding(.bottom, 3)
                    Spacer()
                }
                HStack{
                    Text("$" + String(Int(self.viewModel.budget.amount))).font(.body).foregroundColor(Color(.lightGray)).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            VStack{
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
            }.padding(.trailing, 20).padding(.top)
            
        }.background(Color(.white).cornerRadius(20).padding(.bottom, 5))
    }
    
    var savings: some View{
        HStack{
            
            Image(systemName: "pencil.circle.fill").resizable()
                .frame(width: 30.0, height: 30.0).foregroundColor(Color(.systemGreen)).padding(.leading)
            
            VStack(spacing: 0){
                
                HStack{
                    Text("Savings Goal").font(.system(size: 17)).foregroundColor(Color(.black)).bold().padding(.leading).padding(.top).padding(.bottom, 3)
                    Spacer()
                }
                HStack{
                    Text("$" + String(Int(self.viewModel.budget.amount * self.viewModel.budget.savingsPercent))).font(.body).foregroundColor(Color(.lightGray)).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            VStack{
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
            }.padding(.trailing, 20).padding(.top)
            
        }.background(Color(.white).cornerRadius(20).padding(.bottom, 5))
    }
    
    var categories: some View{
        HStack{
            
            Image(systemName: "pencil.circle.fill").resizable()
                .frame(width: 30.0, height: 30.0).foregroundColor(Color(.systemGreen)).padding(.leading)
            
            VStack(spacing: 0){
                
                HStack{
                    Text("Budgets").font(.system(size: 17)).foregroundColor(.black).bold().padding(.leading).padding(.top).padding(.bottom, 3)
                    Spacer()
                }
                HStack{
                    Text("Set Budgets").font(.body).foregroundColor(Color(.lightGray)).padding(.leading).padding(.bottom)
                    Spacer()
                }
                

            }
            
            VStack{
                Image(systemName: "chevron.right").foregroundColor(Color(.lightGray)).font(Font.system(.headline).bold())
            }.padding(.trailing, 20).padding(.top)
            
            
        }.background(Color(.white).cornerRadius(20).padding(.bottom, 5))
    }
    
    var body: some View {
        
            
                
                
                
                
                

                
        List{
            VStack{
                //BudgetCardView(budget: self.viewModel.budget, viewModel: nil).background(Color(.systemGreen)).cornerRadius(20).padding(.vertical, 5).padding(.horizontal, 7).shadow(radius: 5)
                


                Button(action: {
                    // What to perform
                    self.viewModel.editIncome()
                }) {
                    // How the button looks like
                    income.padding(.top)
                }.buttonStyle(PlainButtonStyle())
                Button(action: {
                    // What to perform
                    self.viewModel.editSavings()
                }) {
                    // How the button looks like
                    savings
                }.buttonStyle(PlainButtonStyle())
                Button(action: {
                    // What to perform
                    self.viewModel.editBudget()
                }) {
                    // How the button looks like
                    categories
                }.buttonStyle(PlainButtonStyle())
                
                
                Spacer()
            }.padding(.top)
        }
                
                
                
                

                
                
            
        
        
    }
}


