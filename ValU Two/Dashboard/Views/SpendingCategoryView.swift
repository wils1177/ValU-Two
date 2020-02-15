//
//  SpendingCategoryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCategoryView: View {
    
    var viewData: SpendingCategoryViewData
    
    init(viewData : SpendingCategoryViewData){
        print("Im drawing the spending category now")
        print(viewData.name)
        print(viewData.spent)
        self.viewData = viewData
    }
    
    var body: some View {
        VStack{
            
            
            HStack{
                
                BudgetCategoryIconView(icon: viewData.icon, percentage: viewData.percentage)
                Text(viewData.name).font(.headline).lineLimit(1)
                Spacer()
                Text(viewData.spent).font(.headline).lineLimit(1)
                Text(viewData.limit).font(.headline).lineLimit(1)
                
            }
            Divider()
            

        }
    }
}


