//
//  CategoryCardView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/4/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryCardView<Model>: HasButtonRows, View where Model: CategoryListViewModel {
    var buttonArray = [[CategoryButton]]()
    
    var viewData : BudgetCategoryViewData
    var presentor : Model?
    
    init(presentor: Model?, viewData: BudgetCategoryViewData){
        self.viewData = viewData
        self.buttonArray = generateButtonArray(buttonList: self.viewData.categories)
        self.presentor = presentor
    }
    
    
    
    
    var body: some View {
        VStack{
          
            VStack(alignment: .leading){
          
          HStack{
            
            Text(self.viewData.icon).font(.largeTitle)
            Text(self.viewData.sectionTitle).font(.title).fontWeight(.bold)
            Spacer()
            //CategoryButtonView(text: "Add Section")
            }
            
                HStack{
                    Text("You've spent " + self.viewData.amountSpent + " in the last 30 days")
                    Spacer()
                }
                
                
            
          
          }.padding()
            
            
            
            ForEach(self.buttonArray, id: \.self){ row in
                
                HStack {
                    
                ForEach(row, id: \.self){button in
                    
                    CategoryButtonView(presentor: self.presentor!, button: button)
                    
                }
                    
                    
                }.padding(10)
                                
            }
          
        
          

          }.background(Color(.white)).cornerRadius(10).shadow(radius: 10).padding()
    }
}

extension HasButtonRows{
    func generateButtonArray(buttonList: [CategoryButton]) -> [[CategoryButton]]{
            
        var charCount = 1
        var all = [[CategoryButton]]()
        var row = [CategoryButton]()
        for category in buttonList {
            
            charCount = charCount + category.name.count
            
            if charCount >= 34{
                all.append(row)
                row = [CategoryButton]()
                charCount = category.name.count
            }
            
            
            row.append(category)
            
            
        }
        
        all.append(row)
        return all
        
    }
}



