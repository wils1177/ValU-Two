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
    
    var labelData : TransactionBudgetLabelViewData?
    
    init(viewData: CategoryMatch, viewModel: TransactionDetailViewModel){
        self.viewData = viewData
        self.viewModel = viewModel
        
        self._amountText = State(initialValue: String(viewData.amount))
        
        self.labelData = viewModel.getLabelViewData(category: viewData.spendingCategory!)
        
    }
    
    func getCategoryName() -> String{
        return (viewData.spendingCategory?.name ?? "name gone")
    }
    
    var body: some View {
        VStack{
            
            HStack{
                TransactionIconView(icons: [viewData.spendingCategory?.icon ?? "icon gone"]).padding(.trailing, 2)
                VStack(alignment: .leading, spacing: 3){
                    Text(getCategoryName()).font(.system(size: 18, design: .rounded)).bold()
                    if labelData != nil{
                        SingleBudgetLabel(label: labelData!)
                    }
                }
                
                Spacer()
                CustomInputTextField(text: self.$amountText, placeHolderText: "Amount", textSize: .systemFont(ofSize: 18), alignment: .right, delegate: self.viewModel, key: self.viewData.id?.uuidString ?? "", style: UITextField.BorderStyle.roundedRect)
                .frame(width: 80)
            }
            

            
            
            
        }
        
    }
}

