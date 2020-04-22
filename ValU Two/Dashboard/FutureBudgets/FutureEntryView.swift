//
//  FutureEntryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/21/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI



struct FutureEntryView: View {
    
    var budget: Budget
    
    @State var isShowingDeleteAlert = false
    
    
    func getPlanned() -> String{
        return "$" + String(Int(self.budget.getAmountAvailable()))
    }
    

    
    func getPercentage() -> Float{
        return self.budget.spent / self.budget.getAmountAvailable()
    }
    
    
    
    
    var body: some View {
        VStack{

                HStack{
                    HStack{
                        
                        HStack{
                            Text(getPlanned()).font(.system(size: 28)).fontWeight(.bold)
                            Text("Planned").font(.headline).fontWeight(.bold).foregroundColor(Color(.gray))
                            Spacer()
                        }
                        
                        
                    }

                    Spacer()
            
                    
                }
                
            
                
        }.padding(.horizontal).padding(.bottom)
        
        
    }
}

