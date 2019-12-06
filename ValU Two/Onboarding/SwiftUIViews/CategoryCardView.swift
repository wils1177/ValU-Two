//
//  CategoryCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/4/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryCardView: View {
    var buttonArray = [[String]]()
    
    var viewData : BudgetCategoryViewData
    var presentor : BudgetCardsPresentor?
    
    init(presentor: BudgetCardsPresentor?, viewData: BudgetCategoryViewData){
        self.viewData = viewData
        self.buttonArray = generateButtonArray()
        self.presentor = presentor
    }
    
    func generateButtonArray() -> [[String]]{
            
        var charCount = 0
        var all = [[String]]()
        var row = [String]()
        for name in self.viewData.categories {
            
            charCount = charCount + name.count
            
            if charCount >= 29{
                all.append(row)
                row = [String]()
                charCount = name.count
            }
            
            
            row.append(name)
            
            
        }
        
        all.append(row)
        return all
        
    }
    
    
    var body: some View {
        VStack{
          
            VStack(alignment: .leading){
          
          HStack{
            
            Text("🍿").font(.largeTitle)
            Text(self.viewData.sectionTitle).font(.title).fontWeight(.bold)
            Spacer()
            //CategoryButtonView(text: "Add Section")
            }
            
          
          }.padding()
            
            ForEach(self.buttonArray, id: \.self){ row in
                
                HStack {
                    
                ForEach(row, id: \.self){button in
                    
                    CategoryButtonView(presentor: self.presentor, text: button)
                    
                }
                    
                    
                }.padding(10)
                                
            }
          
        
          

          }.background(Color(.white)).cornerRadius(10).shadow(radius: 10).padding()
    }
}

struct CategoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCardView(presentor: nil, viewData: BudgetCategoryViewData(sectionTitle: "test", categories: ["hi", "hello"]))
    }
}
