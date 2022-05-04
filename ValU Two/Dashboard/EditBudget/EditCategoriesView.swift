//
//  EditCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoriesView: View {
    
    @ObservedObject var viewModel : EditCategoryViewModel
    
    
    
    init(viewModel : EditCategoryViewModel){
        self.viewModel = viewModel
        UITextView.appearance().backgroundColor = .systemGroupedBackground
    }
    
    var transactionRuleSection : some View{
        
        VStack{
            HStack{
                Image(systemName: "bookmark.fill").foregroundColor(globalAppTheme.themeColorPrimary).padding(.horizontal, 8)
                Toggle(isOn: withAnimation{$viewModel.saveRule}) {
                    Text("Remember for Merchant").font(.system(size: 15, design: .rounded)).fontWeight(.semibold)
                }.padding(.trailing, 5)
            }
            
            if viewModel.saveRule{
                Divider()
                VStack{
                    HStack{
                        Text("If transaction name contains: ").font(.system(size: 20, design: .rounded)).foregroundColor(globalAppTheme.themeColorPrimary).fontWeight(.semibold)
                        Spacer()
                    }
                    
                    TextEditor(text: self.$viewModel.transactionRuleName).font(.system(size: 18, design: .rounded)).frame(minWidth: 0, maxWidth: 400, minHeight: 0, maxHeight: 600).padding(10).background(Color(.systemGroupedBackground)).cornerRadius(14)
                    
                    HStack{
                        
                        Button(action: {
                            // What to perform
                            self.viewModel.transactionRuleName = ""
                        }) {
                            // How the button looks like
                            NavigationBarTextButton(text: "Clear")
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // What to perform
                            self.viewModel.resetRuleName()
                        }) {
                            // How the button looks like
                            NavigationBarTextButton(text: "Reset")
                        }
                        
                        
                        
                        
                        
                    }.padding(.top, 10)
                }.padding()
                
            }
        }.padding(10).background(Color(.tertiarySystemBackground)).cornerRadius(10).padding(.horizontal).padding(.top)
        
    }
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                        
                         
                         VStack{

                             
                                transactionRuleSection
                               
                               
                            
                            
                            HStack{
                                Text("When selected, ValU will remeber your choices for future transactions from the same merchant.").font(.footnote).foregroundColor(Color(.lightGray))
                            }.padding(.horizontal, 10).padding(.bottom)
                             
                             
                            
                            if self.viewModel.budgetSections.count != 0{
                                ForEach(self.viewModel.budgetSections, id: \.self){ section in
                                    EditCategoryCardBudgetSection(section: section, viewModel: self.viewModel).padding(.bottom).padding(.bottom)
                                }.padding(.horizontal)
                                
                                if self.viewModel.unassignedBudgetCategories.count > 0{
                                    EditCategoryCardUnassignedView(categories: self.viewModel.unassignedBudgetCategories, viewModel: self.viewModel).padding(.bottom).padding(.bottom).padding(.horizontal)
                                }
                                
                            }
                            else{
                                ForEach(self.viewModel.spendingCategories, id: \.self){ category in
                                    EditCategoryCard(category: category, viewModel: self.viewModel).padding(.bottom).padding(.bottom)
                                }.padding(.horizontal)
                            }
                            
                            
                            
                            
                            
                         }.listStyle(SidebarListStyle())
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Change Category", displayMode: .large)
            .navigationBarItems(
                
                leading:
                
                    Button(action: {
                                     self.viewModel.dismiss()
                                 }){
                
                        NavigationBarTextButton(text: "Cancel")
                                             
                }
                
                ,trailing: Button(action: {
                                 self.viewModel.submit()
                             }){
            
                    NavigationBarTextButton(text: "Done")
                                         
            })
            
        }
        
            
        
        
                
        
        
    }
    
}



//struct EditCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
 //       EditCategoriesView(viewModel: nil)
 //   }
//}
