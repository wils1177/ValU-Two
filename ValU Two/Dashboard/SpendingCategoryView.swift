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
        self.viewData = viewData
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(viewData.icon).font(.headline).fontWeight(.bold).lineLimit(1)
                Text(viewData.name).font(.headline).fontWeight(.bold).lineLimit(1)
                Spacer()
                Text(viewData.spent).font(.headline).fontWeight(.bold).lineLimit(1)
            }
            ProgressBarView(percentage: viewData.percentage, color: Color(.purple))
            
        }
    }
}


