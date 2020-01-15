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
    
    init(viewModel : TransactionViewData){
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack{
            Button(action: {
                print("clicked the category button")
            }){
            ZStack{
                
                //Rectangle().frame(width: 60, height: 60).foregroundColor(.clear).cornerRadius(10).shadow(radius: 3)
                Text(viewModel.icon).font(.largeTitle)
            }
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

        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 5).padding(.leading).padding(.trailing).padding(7)
    }
}


struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(viewModel: TransactionViewData(name: "Poop fealldkjafsdlkfjaklsdjf", amount: "$50.00", category: "test", date: "34/4523", icon: "5"))
    }
}

