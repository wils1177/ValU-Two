//
//  CategoryAmountRowView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 3/29/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CategoryAmountRowView: View {
    
    @ObservedObject var viewData : CategoryMatch
    var viewModel : TransactionDetailViewModel
    @State var amountText : String
    
    
    init(viewData: CategoryMatch, viewModel: TransactionDetailViewModel){
        self.viewData = viewData
        self.viewModel = viewModel
        
        self._amountText = State(initialValue: String(viewData.amount))
        
    }
    
    func getCategoryName() -> String{
        return (viewData.spendingCategory!.name ?? "name gone")
    }
    
    var body: some View {
        HStack{
            Text(viewData.spendingCategory!.icon ?? "icon gone").font(.title)
            Text(getCategoryName())
            Spacer()
            CustomInputTextField(text: self.$amountText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 15), alignment: .right, delegate: self.viewModel, key: self.viewData.id!.uuidString, style: UITextField.BorderStyle.roundedRect)
            .frame(width: 80)
        }
    }
}

