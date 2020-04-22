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
    
    func makeMoneyString(amount: Float) ->String{
        "$" + String(Int(round(amount)))
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(makeMoneyString(amount: viewData.income * -1)).font(.largeTitle).bold().foregroundColor(Color(.systemGreen))
                Spacer()
                Text(makeMoneyString(amount: viewData.expenses)).font(.largeTitle).bold().foregroundColor(Color(.systemRed))
            }.padding(.horizontal).padding(.horizontal, 30).padding(.bottom, 7)
            HStack{
                Text("Income").font(.headline).bold().foregroundColor(Color(.gray))
                Spacer()
                Text("Expenses").font(.headline).bold().foregroundColor(Color(.gray))
            }.padding(.horizontal).padding(.horizontal, 30)
        }
    }
}

