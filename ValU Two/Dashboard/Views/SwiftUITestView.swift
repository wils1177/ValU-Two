//
//  SwiftUITestView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/9/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI


struct BudgetCardView: View {
    
    let viewModel : BudgetCardViewModel
    
    init(viewModel : BudgetCardViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack{
            HStack{
                Text(self.viewModel.viewData.title).font(.title).fontWeight(.bold)
                Spacer()
                Image(systemName: "pencil.circle")
            }
            HStack{
                
                HStack{
                    
                    //Spacer()
                    VStack{
                        Text(self.viewModel.viewData.spent).font(.system(size: 28)).fontWeight(.bold)
                        Text("Spent").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                    }
                    
                    
                }.padding(.leading).padding(.leading)

                Spacer()
                
                HStack{
                    
                    
                    VStack{
                        //Spacer()
                        Text(self.viewModel.viewData.remaining).font(.system(size: 28)).fontWeight(.bold)
                        Text("Remaning").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                        
                    }
                    
                    
                }.padding(.trailing).padding(.trailing)
                
            }.padding(.bottom)
            
            
            
            
            
            
            
            
            ProgressBarView(percentage: self.viewModel.viewData.percentage, color: Color(.black))
            
            
            
            
            
            
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 20).padding(.leading).padding(.trailing).padding(.bottom)
        
        
        
        
    }
}

/*
#if DEBUG
struct BudgetCardView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetCardView(viewData: BudgetCardViewData(remaining: "500", spent: "500", percentage: CGFloat(0.5)))
    }
}
#endif
*/

