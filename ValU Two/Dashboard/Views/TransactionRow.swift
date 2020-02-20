//
//  TransactionRow.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/12/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionRow: View {
    
    var coordinator : TransactionRowDelegate
    var viewData : TransactionViewData
    @State var showingDetail = false
    
    init(coordinator: TransactionRowDelegate, viewData :TransactionViewData){
        self.coordinator = coordinator
        self.viewData = viewData
    }
    
    var body: some View {
        HStack{

            Button(action: {
                print("clicked the category button")
                self.coordinator.showEditCategory(transaction: self.viewData.rawTransaction)
            }){
            ZStack{
                
                Text(viewData.icon).font(.largeTitle)
            }
            }.buttonStyle(BorderlessButtonStyle())

            VStack{
                HStack{
                    Text(viewData.name).font(.headline).bold().lineLimit(1)
                    Spacer()
                }
                HStack{
                    Text(viewData.category).font(.subheadline)
                    Spacer()
                }
                
            }.padding(.leading, 5)
            
            
            Spacer()
            VStack{
                HStack{
                    Spacer()
                    Text(viewData.amount).font(.headline).bold().lineLimit(1)
                    
                }
                HStack{
                    Spacer()
                    Text(viewData.date).font(.subheadline).lineLimit(1)
                    
                }
                
            }.frame(maxWidth: 70)

        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5).padding(3)
    }
}




