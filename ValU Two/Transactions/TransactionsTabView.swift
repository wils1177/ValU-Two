//
//  TransactionsTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionsTabView: View {
    
    @ObservedObject var viewModel : TransactionsTabViewModel
    @ObservedObject var filterModel : TransactionFilterModel
    
    @State var searchText : String = ""
    @State var isSearching : Bool = false
    
    @State var isEditing = false
    @State private var selection = Set<Transaction>()
    
    var transactionService : TransactionService
    
    init(viewModel: TransactionsTabViewModel, filterModel : TransactionFilterModel){
        self.viewModel = viewModel
        self.filterModel = filterModel
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        self.transactionService = TransactionService()
        
    }
    
    func getDateString(date: Date) -> String{
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "EEEE, MMMM dd"
        return formatter3.string(from: date)
    }
    
    
    var filteredSections : [TransactionDateSection]{
        let sections = self.viewModel.getTransactionsByDate()
        if searchText.isEmpty { return sections }
        
        return sections.map { dateSection in
            var dateSectionCopy = dateSection
            dateSectionCopy.transactions = dateSection.transactions.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
            return dateSectionCopy
        }.filter{ !$0.transactions.isEmpty }
    }
    
    
    var body: some View {
            
        List(selection: $selection){
            //self.searchBar
            if self.viewModel.filterModel.areThereAnyFilterEnabled(){
                SelectedFilterPillsView(filterModel: self.viewModel.filterModel).padding(.horizontal, 20)
            }
            
            ForEach(filteredSections, id: \.self) { dateSection in
                
                Section(header: Text(getDateString(date: dateSection.date)).font(.system(size: 21, design: .rounded)).fontWeight(.bold).foregroundColor(Color(.black))){
                    
                    ForEach(dateSection.transactions, id: \.self) { transaction in
                        TransactionRow(coordinator: self.viewModel.coordinator!, transaction : transaction, transactionService: self.transactionService).padding(.vertical, 3)
                    }
                    
                }.textCase(nil)
                
                
            }
            
            //LazyVStack{

                /*
                ForEach(self.viewModel.getTransactionsList().filter({$0.name!.localizedCaseInsensitiveContains(self.searchText) || searchText.isEmpty}), id: \.self) { transaction in
                    
                    TransactionRow(coordinator: self.viewModel.coordinator!, transaction : transaction, transactionService: self.transactionService).padding(.vertical, 3)
                    
                }
                 */
            //}.padding(.top, 10)
                
            
            

        }
        
        .refreshable {
            print("Do your refresh work here")
            let refreshModel = OnDemandRefreshViewModel()
            refreshModel.somethingToDoWhenRefrehIsDone = self.viewModel.refreshCompleted
            refreshModel.startLoadingAccounts()
            
        }
            .searchable(text: self.$searchText)
            
            .navigationBarTitle(Text("Transactions"))
            .navigationBarItems(
                
                leading:
                   
                    EditButton()
                
                ,
                                
                                
                                trailing:
            
            Button(action: {
                self.viewModel.coordinator?.showFilterEditView(filterModel: self.viewModel.filterModel)
            }){
            ZStack{
                
                NavigationBarTextIconButton(text: "Filter", icon:"line.horizontal.3.decrease.circle")
            }
            }
            
            
            
        )
            
        
            
        
    }
}


