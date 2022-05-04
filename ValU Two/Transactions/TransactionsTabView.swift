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
    
    var isAnySearch : Bool{
        if searchText != ""{
            return true
        }
        else if filterModel.areThereAnyFilterEnabled(){
            return true
        }
        else {return false}
    }
    
    
    
    init(viewModel: TransactionsTabViewModel, filterModel : TransactionFilterModel){
        self.viewModel = viewModel
        self.filterModel = filterModel
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()

               // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
        
        self.transactionService = TransactionService()
        
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
                SelectedFilterPillsView(filterModel: self.viewModel.filterModel).listRowBackground(Color.clear)
            }
            
            if filteredSections.count > 0 {
                ForEach(filteredSections, id: \.self) { dateSection in
                    
                    Section(header: TransactionDateSectionHeader(transactionSection: dateSection, isAnySearch: self.isAnySearch)){
                        
                        ForEach(dateSection.transactions, id: \.self) { transaction in
                            TransactionRow(coordinator: self.viewModel.coordinator!, transaction : transaction, transactionService: self.transactionService).padding(.vertical, 3)
                        }
                        
                    }.textCase(nil)
                    
                    
                }
            }
            else{
                Section(){
                    HStack{
                        Spacer()
                        VStack(alignment: .center){
                            Text("No Transactions").font(.system(size: 30, design: .rounded)).bold()
                        }
                        Spacer()
                    }
                    
                    
                }.padding()
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
            let refreshModel = OnDemandRefreshViewModel()
            refreshModel.somethingToDoWhenRefrehIsDone = self.viewModel.refreshCompleted
            await refreshModel.refreshAllItems()
            
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


struct TransactionDateSectionHeader: View {
    
    var transactionSection: TransactionDateSection
    
    var isAnySearch : Bool = false
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    func getDateString(date: Date) -> String{
        
        if Calendar.current.isDateInToday(date){
            return "Today"
        }
        
        if Calendar.current.isDateInYesterday(date){
            return "Yesterday"
        }
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "EEEE, MMMM dd"
        return formatter3.string(from: date)
    }
    
    var body : some View{
        HStack{
            Text(getDateString(date: transactionSection.date)).font(.system(size: 21, design: .rounded)).foregroundColor((colorScheme == .dark) ? Color.white : Color.black).fontWeight(.bold)
            Spacer()
            if transactionSection.amount != nil && !isAnySearch{
                Text(CommonUtils.makeMoneyString(number: Int(transactionSection.amount ?? 0.0))).font(.system(size: 18, design: .rounded)).fontWeight(.bold).foregroundColor(globalAppTheme.themeColorPrimary)
            }
        }
    }
}
