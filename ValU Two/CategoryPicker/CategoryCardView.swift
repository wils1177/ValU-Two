//
//  CategoryCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/4/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryCardView<Model>: View where Model: CategoryListViewModel {
    
    var presentor : Model?
    
    var category : SpendingCategory
    
    init(presentor: Model?, category: SpendingCategory){
        self.category = category
        self.presentor = presentor
    }
    
    
    
    
    var body: some View {
        VStack{
          
            VStack(alignment: .leading){
          
          HStack{
            
            Text(self.category.icon!).font(.largeTitle)
            Text(self.category.name!).font(.title).fontWeight(.bold)
            Spacer()
            //CategoryButtonView(text: "Add Section")
            }.padding()
            

          
          }
            
 
            ForEach(self.category.subSpendingCategories?.allObjects as! [SpendingCategory], id: \.self){subCategory in
                    
                    CategoryButtonView(category: subCategory)
                    
                
                    
                    
            }
                                
            
          
        
          

          }.background(Color(.white)).cornerRadius(10).padding()
    }
}





