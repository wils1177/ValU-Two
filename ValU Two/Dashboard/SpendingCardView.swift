//
//  SwiftUIBudgetView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/13/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCardView: View {
    
    var viewModel : SpendingCardViewModel
    
    init(viewModel : SpendingCardViewModel){
        self.viewModel = viewModel
    }
    
    
    var body: some View {
            
        VStack(){
            
            VStack{
            
            HStack{
                Text(self.viewModel.viewData.cardTitle).font(.title).fontWeight(.bold)
                Spacer()
            }.padding(.bottom)

            VStack{
                
                ForEach(self.viewModel.viewData.categories, id: \.self){ category in
                    
                    VStack{
                        HStack{
                            Text(category.icon).font(.headline).fontWeight(.bold).lineLimit(1)
                            Text(category.name).font(.headline).fontWeight(.bold).lineLimit(1)
                            Spacer()
                            Text(category.spent).font(.headline).fontWeight(.bold).lineLimit(1)
                        }
                        ProgressBarView(percentage: category.percentage, color: Color(.purple))
                        
                    }
                    

                    
                }
                
            }
            
            
            
            }.padding()
            
            HStack{
                Image(systemName: "tortoise")
                Spacer()
            }.padding()
            

            }.background(Color(.white)).cornerRadius(10).shadow(radius: 10).padding(.leading).padding(.trailing)
        
        
    }
}

/*
struct SwiftUIBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SpendingCardView()
    }
}
*/
