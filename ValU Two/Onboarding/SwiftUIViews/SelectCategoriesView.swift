//
//  SelectCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/3/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SelectCategoriesView: View {
    
    var viewData : [BudgetCategoryViewData]
    var presentor : BudgetCardsPresentor?

    init(presentor: BudgetCardsPresentor?, viewData: [BudgetCategoryViewData]){
        self.viewData = viewData
        self.presentor = presentor
    }
    

    
    
    var body: some View {
        
        VStack{
            
            
            VStack{
                
                Spacer()
                
                
                
                
                ZStack{
                    
                    
                    
            ScrollView(.vertical, content: {
                VStack{
                    
                    VStack{
                        Text("Go ahead and pick some budget categories, ya nut!").bold().lineLimit(nil).multilineTextAlignment(.center).foregroundColor(.white).padding()
                        }.padding()
                    
                    ForEach(self.viewData, id: \.self){ cardData in
                        CategoryCardView(presentor: self.presentor, viewData: cardData)
                    }
                    
                }
            })
                    
                    
                    
                    VStack{
                    Spacer()
                    
                        HStack{
                            Spacer()
                            Button(action: {
                                self.presentor?.submit()
                            }){
                                
                                HStack{
                                    
                                    ZStack{
                                        Text("Done").font(.subheadline).foregroundColor(.black).bold().padding()
                                        
                                        
                                        
                                    }
                                    
                                }.background(LinearGradient(gradient:  Gradient(colors: [.white, .white]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 20).padding()
                                
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                
                }
            }
            .background(Color(.black)).cornerRadius(40).shadow(radius: 20).edgesIgnoringSafeArea(.bottom).padding(.top, 20)
            
            
            
            
        }.navigationBarTitle(Text("Budget Categories"))
        
        
        
        
    }
}

struct SelectCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCategoriesView(presentor: nil, viewData: [BudgetCategoryViewData(sectionTitle: "test", categories: ["what", "no"])])
    }
}
