//
//  SwiftUIHomeView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIHomeView: View {
    var body: some View {
        
        ScrollView(.vertical, content: {
            VStack(alignment: .leading){
                HStack{
                    Text("Hello Clay").font(.largeTitle).fontWeight(.heavy).padding()
                    Spacer()
                    
                    
                    Button(action: {
                        
                    }){
                        ZStack{
                            Image(uiImage: UIImage(systemName: "bell")!).padding().background(Color(.white)).cornerRadius(50).shadow(radius: 3)
                        }.padding(.trailing, 30)
                        
                    }
                    
                    
                    
                }
                SwiftUITestView(viewData: BudgetCardViewData(income: "$1000.00", spent: "$339.00"))
                SwiftUIBudgetView()
                SwiftUISavingsCardView()
                SwiftUIAccountsView()
                Spacer()
                
                
            }
            
            
        }).padding().padding().padding(.bottom, 68)
        
        
        
        
    }
}

struct SwiftUIHomeView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIHomeView()
    }
}
