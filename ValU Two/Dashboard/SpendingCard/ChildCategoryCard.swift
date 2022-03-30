//
//  ChildCategoryCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ChildCategoryCard: View {
    
    var limit : Double
    var spent : Double
    var icon : String
    var name : String
    var color: Color
    
    func getPercentage() -> Double{
        if self.limit != 0.0{
            return spent / limit
        }
        else{
            return 0.0
        }
    }
    
    
    
    var body: some View {
        HStack(spacing: 0){
            
            VStack(alignment: .leading){
                Text(self.name).font(.system(size: 22, design: .rounded)).bold().lineLimit(1)
                
            }
            
            
                
                Spacer()
            
            Text("\(Text(CommonUtils.makeMoneyString(number: spent)).font(.system(size: 18, design: .rounded)).foregroundColor(self.color).bold()) / \(Text(CommonUtils.makeMoneyString(number: limit)))").font(.system(size: 18, design: .rounded)).bold().foregroundColor(Color(.gray)).lineLimit(1)
                
            
                
            }

        
    }
}


