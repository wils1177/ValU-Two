//
//  SwiftUIBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCardView: View {
    
    @ObservedObject var viewModel : SpendingCardViewModel
    
    init(viewModel : SpendingCardViewModel){
        //print("Spending Card init")
        self.viewModel = viewModel
    }
    
    
    var body: some View {
            
        VStack(){
            
            VStack{
            
            HStack{
                Text(self.viewModel.viewData.cardTitle).font(.title).fontWeight(.bold)
                Spacer()
            }.padding(.bottom)
                
            HStack{
                //Text(self.viewModel.viewData.cardTitle).font(.title).fontWeight(.bold)
                Text("Category").font(.headline).foregroundColor(Color(.gray))
                Spacer()
                Text("Spent").font(.headline).foregroundColor(Color(.gray))
                Text("Budeted").font(.headline).foregroundColor(Color(.gray))
            }
            Divider()
            
            ForEach(self.viewModel.viewData.categories, id: \.self){ category in
                
                NavigationLink(destination: TransactionList(categoryName: category.name)){
                    SpendingCategoryView(viewData: category)
                }.buttonStyle(PlainButtonStyle())
                
                
            }
            
            
            
            }.padding()
            
            
            

            }.background(Color(.white)).cornerRadius(10).shadow(radius: 10).padding(.leading).padding(.trailing)
        
        
    }
}




