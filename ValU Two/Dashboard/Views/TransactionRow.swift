//
//  TransactionRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
    
    var viewModel : TransactionViewData
    @State var showingDetail = false
    
    init(viewModel : TransactionViewData){
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{

            Button(action: {
                print("clicked the category button")
                self.showingDetail.toggle()
            }){
            ZStack{
                
                Text(viewModel.icon).font(.largeTitle)
            }
            }.buttonStyle(BorderlessButtonStyle()).sheet(isPresented: $showingDetail) {
                EditCategoriesView(viewModel: EditCategoryViewModel(transaction: self.viewModel.rawTransaction), onDismiss: {self.showingDetail = false})
            }

            VStack{
                HStack{
                    Text(viewModel.name).font(.headline).bold().lineLimit(1)
                    Spacer()
                }
                HStack{
                    Text(viewModel.category).font(.subheadline)
                    Spacer()
                }
                
            }.padding(.leading, 5)
            
            
            Spacer()
            VStack{
                HStack{
                    Spacer()
                    Text(viewModel.amount).font(.headline).bold().lineLimit(1)
                    
                }
                HStack{
                    Spacer()
                    Text(viewModel.date).font(.subheadline).lineLimit(1)
                    
                }
                
            }.frame(maxWidth: 70)

        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5).padding(3)
    }
}




