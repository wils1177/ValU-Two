//
//  HistoricalTransactionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 8/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoricalTransactionsView: View {
    
    @ObservedObject var viewModel : HistoricalTransactionsViewModel
    var coordinator : BudgetEditableCoordinator?
    var budgetCategory: BudgetCategory
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var transactionsService = TransactionService()
    
    @State private var searchText = ""
    
    @State private var transactionType = 0
    
    @State var showRemoveMerchantAlert = false
    
    @State var showAddMerchantAlert = false
    
    @State var merchantTotalRemove : MerchantTotals?
    
    @State var merchantTotalToAdd : MerchantTotals?
    
    var color : Color {
        return colorMap[Int(self.budgetCategory.budgetSection!.colorCode)]
    }
    
    init(viewModel: HistoricalTransactionsViewModel, budgetCategory: BudgetCategory){
        self.viewModel = viewModel
        self.budgetCategory = budgetCategory
    }
    
    func isMerchantTotalInCategory(total: MerchantTotals) -> Bool{
        let name = self.budgetCategory.spendingCategory!.name!
        let compareName = self.viewModel.getCategoryNameForMerchant(merchantTotal: total)
        if name == compareName{
            return true
        }
        else{
            return false
        }
    }
    
    func removeMerchant(){
        if self.merchantTotalRemove != nil{
            self.viewModel.removeMerchantFromCategory(merchantToatl: self.merchantTotalRemove!)
        }
        
    }
    
    
    
    var searchResults: [MerchantTotals] {
            if searchText.isEmpty {
                return self.viewModel.getMerchantTotals(budgetCategory: self.budgetCategory)
            } else {
                return self.viewModel.getMerchantTotals(budgetCategory: self.budgetCategory).filter { $0.name.contains(searchText) }
            }
    }
    
    var searchResultsAll: [MerchantTotals]{
        if searchText.isEmpty {
            return self.viewModel.getMerchantTotals()
        } else {
            return self.viewModel.getMerchantTotals().filter { $0.name.contains(searchText) }
        }
    }
    
    
    
    var noTransactionsForCategoryView : some View{
        
        VStack(alignment: .center){
            
            Text("No Transactions for Category").font(.system(size: 25, weight: .bold, design: .rounded)).multilineTextAlignment(.center).padding(.bottom, 10)
            
            Text("If you think you do have transactions for this category, you can select 'All Transactions' to begin tagging transactions to this category.").font(.system(size: 18, weight: .regular, design: .rounded)).multilineTextAlignment(.center)
        }
        
    }
    
    var categoryTotalSection: some View{
        Section{
            HStack{
                VStack(alignment: .leading){
                    Text(self.viewModel.getSuffixText(bugetCategory: budgetCategory)).font(.system(size: 18, weight: .semibold, design: .rounded)).foregroundColor(Color(.lightGray))
                    
                    Text(self.viewModel.getCategoryTotalText(budgetCategory: self.budgetCategory)).font(.system(size: 34, design: .rounded)).foregroundColor(colorMap[Int(self.budgetCategory.budgetSection!.colorCode)]).bold()
                    
                    
                    
                }
                
                
                Spacer()
            }
            
        }//.listRowBackground(.clear)
    }
    
    
    var categorySection: some View{
        
        Section(header: Text("MERCHANTS")){
            if self.viewModel.getTransactionsForCategory(budgetCategory: budgetCategory).count > 0{
                
                    ForEach(searchResults, id: \.self) { totals in
                        
                        Button(action: {
                            // What to perform
                            self.coordinator?.showListOfTransactions(title: totals.name, list: totals.transactions)
                        }) {
                            // How the button looks like
                            HStack(alignment: .center){
                                
                                
                                Text( totals.name).lineLimit(2).font(.system(size: 17, weight: .regular, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                Spacer()
                                Text(CommonUtils.makeMoneyString(number: totals.amount)).font(.system(size: 17, weight: .regular, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                
                                Image(systemName: "multiply.circle.fill").font(.system(size: 19, weight: .heavy, design: .rounded)).foregroundColor(Color(.lightGray)).padding(.leading, 3)
                                
                                    .onTapGesture {
                                        
                                        self.merchantTotalRemove = totals
                                        self.showRemoveMerchantAlert.toggle()
                                    }
                                
                                    .alert(isPresented:self.$showRemoveMerchantAlert) {
                                        Alert(title: Text("Remove this merchant?"), message: Text("All transactions associated with this merchant will be removed from this category."), primaryButton: .destructive(Text("Remove")) {
                                            removeMerchant()
                                        }, secondaryButton: .cancel())
                                    }
                            
                            }
                        }
                        
                        
                    }
                
            }
            else{
                self.noTransactionsForCategoryView//.listRowSeparator(.hidden)
            }
        }
        
    }
    
    
    var allMerchantsSection: some View{
        
        Section{
            ForEach(searchResultsAll, id: \.self) { totals in
                
                if !isMerchantTotalInCategory(total: totals){
                    Button(action: {
                        // What to perform
                        self.coordinator?.showListOfTransactions(title: totals.name, list: totals.transactions)
                    }) {
                        // How the button looks like
                        HStack(alignment: .center){
                            
                            TransactionIconView(icons: viewModel.getIconsForMerchant(merchantTotal: totals))
                            
                            VStack(alignment: .leading){
                                Text( totals.name).lineLimit(1).font(.system(size: 17, weight: .bold, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black)
                                
                                Text(self.viewModel.getCategoryNameForMerchant(merchantTotal: totals)).font(.system(size: 17, weight: .semibold, design: .rounded)).lineLimit(1).foregroundColor(Color(.lightGray))
                            }
                            
                            
                            Spacer()
                            
                            
                                NavigationBarTextIconButton(text: " " +  self.budgetCategory.spendingCategory!.icon!, icon: "plus.app", color: self.color)
                                    .onTapGesture {
                                        //self.viewModel.migrateMerchantToCategory(merchantTotal: totals, category: self.budgetCategory)
                                        
                                        self.showAddMerchantAlert.toggle()
                                        self.merchantTotalToAdd = totals
                                    }
                            
                            
                            
                        }
                    }
                }
                
                
                
                
            }
        }
        
    }
    
    
    var body: some View {
        
        
        
        List{
            
            
            
                if self.transactionType == 0 {
                    self.categoryTotalSection
                    self.categorySection
                }
                else{
                    self.allMerchantsSection
                }
            
            
            
            
        }
        .background(Color(.systemGroupedBackground))
        .searchable(text: $searchText)
        .navigationBarTitle(self.budgetCategory.spendingCategory!.name!)
        .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Picker(selection: $transactionType, label: Text("Transactions")) {
                            Text(self.budgetCategory.spendingCategory!.name!).tag(0)
                                Text("All Merchants").tag(1)
                            
                            
                        }.pickerStyle(SegmentedPickerStyle()).listRowSeparator(.hidden)
                }
        }
        
        
        .alert(isPresented:self.$showAddMerchantAlert) {
            Alert(title: Text("Add Merchant to Category?"), message: Text("All Transactions will be tagged to the current category"), primaryButton: .default(Text("Add")) {
                self.viewModel.migrateMerchantToCategory(merchantTotal: self.merchantTotalToAdd!, category: self.budgetCategory)
            }, secondaryButton: .cancel())
        }

    }
}

