//
//  SpendingCardDropDownView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCardDropDownView: View {
    
    @State var condensed = true
    var viewData : SpendingCardViewData
    
    init(viewData: SpendingCardViewData){
        self.viewData = viewData
    }
    
    func getButtonText() -> String{
        if condensed{
            return "Show More"
        }
        else{
            return "Show Less"
        }
    }
    
    var body: some View {
        VStack{
            if !self.condensed{
                
                VStack{
                    
                HStack{
                    //Text(self.viewModel.viewData.cardTitle).font(.title).fontWeight(.bold)
                    Text("Category").font(.headline).foregroundColor(Color(.gray))
                    Spacer()
                    Text("Spent").font(.headline).foregroundColor(Color(.gray))
                    Text("Budeted").font(.headline).foregroundColor(Color(.gray))
                }
                Divider()
                
                    ForEach(self.viewData.categories, id: \.self){ category in
                    
                    Button(action: {
                        print("button doesn't do anything right now")
                    }){
                    ZStack{
                        
                        SpendingCategoryView(viewData: category)
                    }
                    }.buttonStyle(PlainButtonStyle())
                    
                    
                    
                }
                
                
                
                }.padding()
                
            }
            
            HStack{
                Button(action: {
                    print("view condendsed")
                    withAnimation{
                        self.condensed.toggle()
                    }
                    
                }){
                    
                    Text(self.getButtonText()).foregroundColor(Color(.black)).padding(.leading).padding(.top, 5)
                }
                Spacer()
            }
        }
    }
}


