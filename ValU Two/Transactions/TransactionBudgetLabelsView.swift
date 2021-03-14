//
//  TransactionBudgetLabelsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/19/21.
//  Copyright © 2021 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionBudgetLabelViewData : Hashable{
    var name: String
    var icon: String
    var color: Color
    var id = UUID()
}

struct TransactionBudgetLabelsView: View {
    
    var transaction : Transaction
    var labels = [TransactionBudgetLabelViewData]()
    
    init(transaction: Transaction, transactionService: TransactionService){
        self.transaction = transaction
        self.labels = transactionService.getBudgetLabels(transaction: transaction)
    }
    
    @ViewBuilder
    var body: some View {
        
        HStack{
            ForEach(self.labels, id: \.self){ label in
                SingleBudgetLabel(label: label)
            }
        }
        

            
        /*
            if labels.count == 0{
                HStack(spacing:2){
                    Image(systemName: "book").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(.lightGray))
                    Text("No Budget").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(.lightGray))
                }.padding(.horizontal, 3).padding(5).background(Color(.systemGroupedBackground)).cornerRadius(10)
            }
            else if labels.count == 1 {
                SingleBudgetLabel(label: self.labels[0])
            }
            else {
                SingleBudgetLabel(label: self.labels[0])
                HStack(spacing:2){
                    Image(systemName: "ellipsis").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(.lightGray))
                    Text("More").font(.system(size: 12, weight: .heavy)).foregroundColor(Color(.lightGray))
                }.padding(.horizontal, 3).padding(5).background(Color(.systemGroupedBackground)).cornerRadius(10)
            }
            */
        
        
    }
}


struct SingleBudgetLabel: View {
    var label : TransactionBudgetLabelViewData
    
    var body : some View{
        HStack(spacing:2){
            Image(systemName: label.icon).font(.system(size: 12, design: .rounded)).foregroundColor(Color(UIColor(label.color)))
            Text(label.name).font(.system(size: 12, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(UIColor(label.color))).lineLimit(1)
        }.padding(.horizontal, 3).padding(5).background(Color(UIColor(label.color)).opacity(0.3)).cornerRadius(9)
    }
}

