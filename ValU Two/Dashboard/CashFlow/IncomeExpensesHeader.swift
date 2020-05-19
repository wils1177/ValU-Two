//
//  IncomeExpensesHeader.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct IncomeExpensesHeader: View {
    
    var viewData : TransactionDateCache
    
    func getLabel() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        
        return dateFormatter.string(from: self.viewData.startDate!)
        
    }
    
    
    var body: some View {
        
        VStack(spacing: 0.0){
            
            HStack{

                Button(action: {
                    //Action
                    
                }) {
                    VStack(alignment: .leading){
                        HStack{
                            //Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemGreen))
                            Text("Income").font(.headline).bold().foregroundColor(Color(.systemGreen))
                            
                        }
                        Text(CommonUtils.makeMoneyString(number: Int(viewData.income * -1))).font(.title).bold()
                        //Text("Up $400").font(.callout).foregroundColor(Color(.lightGray))
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Divider().frame(height: 55)
                
                Button(action: {
                    //Action
                    
                }) {
                    VStack(alignment: .leading){
                        HStack{
                            //Circle().frame(width: 7, height: 7).foregroundColor(Color(.systemRed))
                            Text("Expenses").font(.headline).bold().foregroundColor(Color(.systemRed))
                        }
                        
                        Text(CommonUtils.makeMoneyString(number: Int(viewData.expenses))).font(.title).bold()
                        //Text("Up $400").font(.callout).foregroundColor(Color(.lightGray))
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Spacer()
                
            }

        }
        
        
        
        
    }
}

