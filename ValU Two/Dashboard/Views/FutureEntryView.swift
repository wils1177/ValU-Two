//
//  FutureEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI



struct FutureEntryView: View {
    
    var viewData : FutureEntryViewData
    var viewModel : BudgetsTabViewModel
    
    @State var isShowingDeleteAlert = false
    
    var body: some View {
        VStack{
            HStack{
                    Text(self.viewData.title).font(.title).fontWeight(.bold)
                    Spacer()
                Button(action: {
                    //Action
                    self.isShowingDeleteAlert.toggle()
                }){
                    
                    Image(systemName: "x.circle.fill").foregroundColor(Color(.gray))

                }.buttonStyle(PlainButtonStyle())
                }
                HStack{
                    Spacer()
                    HStack{
                        
                        HStack{
                            Text(self.viewData.planned).font(.system(size: 28)).fontWeight(.bold)
                            Text("Planned").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                            Spacer()
                        }
                        
                        
                    }.padding(.leading).padding(.leading)

                    Spacer()
            
                    
                }
                
            
                
                SpendingCardDropDownView(viewData: self.viewData.spendingCardViewData)
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5).padding(.leading).padding(.trailing).padding(.bottom)
        .alert(isPresented:self.$isShowingDeleteAlert) {
            Alert(title: Text("Are you sure you want to delete this budget?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                //Delete Action
                self.viewModel.deleteBudget(id: self.viewData.budgetId)
            }, secondaryButton: .cancel())
        }
        
    }
}

