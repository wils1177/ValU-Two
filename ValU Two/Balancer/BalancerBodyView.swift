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
    var test = ["hey"]
    @State var detail = false
    @State var isShowingAddCategory = false
      
      init(viewModel: BudgetBalancerPresentor){
          
          self.viewModel = viewModel
          
          // To remove only extra separators below the list:
          UITableView.appearance().tableFooterView = UIView()

          // To remove all separators including the actual ones:
          UITableView.appearance().separatorStyle = .none
        
      }
    
    func showSheet(){
        self.isShowingAddCategory.toggle()
    }
    
      
      var body: some View {
        
        VStack{
            
            
        
          VStack{
              
              if self.viewModel.viewData.count == 0{
                  
                  ScrollView(.vertical, content: {
                      VStack{
                          
                        //HStack{
                       //     Text("March Budget").font(.title).foregroundColor(.black).bold().padding(.horizontal).padding(.top)
                       //     Spacer()
                       // }.padding(.top)
                          Spacer()
                          VStack{
                                  
                                  Spacer()
                                  HStack{
                                      Text("Add your some categories to your budget!").foregroundColor(Color(.lightGray))
                                      Spacer()
                                  }.padding()

                                      
                                  VStack{
                                      HStack{
                                          Spacer()
                                          
                                          Button(action: {
                                              self.isShowingAddCategory.toggle()
                                          }){
                                              Image(systemName: "plus.circle.fill").imageScale(.large)
                                              Text("Add Category").fontWeight(.bold)
                                          }.buttonStyle(BorderlessButtonStyle())

                                          Spacer()
                                      }.padding()
                                      }.background(Color(.cyan)).cornerRadius(10).padding()
                                          
                                      
                                  
                                  

                              
                              Spacer()
                              
                          }.padding()
                          Spacer()
                          
                      }
                  })
                  
              }
              else{
                  List(self.viewModel.viewData, id: \.self){ category in
                    
                    
                       
                      VStack{
                          if category.index == 0{
                            
                                
                            
                            VStack{
                                SpendingLimitSummaryView(leftToSpend: self.viewModel.leftToSpend!, percentage: self.viewModel.percentage).cornerRadius(10).shadow(radius: 0).padding()
                            }
                                    
                                

                              
                            //HStack{
                            //    Text("March Budget").font(.title).foregroundColor(.black).bold()
                            //    Spacer()
                           // }.padding(.top)
                            
                          }
                         
                            BudgetBalanceCard(viewModel: self.viewModel, viewData: category).padding(.bottom)
                            
                        
                        
                          
                          if category.index == self.viewModel.viewData.count - 1 {
                            VStack{
                                Button(action: {
                                        self.isShowingAddCategory.toggle()
                                    }){
                                        Image(systemName: "plus.circle.fill").resizable()
                                            .frame(width: 40.0, height: 40.0).padding()
                                    }.buttonStyle(BorderlessButtonStyle())
                                }
                                
                                
                            }
                              
                      }
                      
    
                  }
              }
              
            }
          }
              .sheet(isPresented: $isShowingAddCategory, onDismiss: {
                  //self.viewModel.generateViewData()
              }) {
                CategoryPickerBody(viewModel: self.viewModel.categoryPicker, isShowingAddCategory: self.$isShowingAddCategory)
                  
              }
              .onAppear {
              print("balancer appeared")
        }
      }
}


