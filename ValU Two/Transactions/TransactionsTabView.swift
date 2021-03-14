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
    
    var searchBar: some View {
        
        HStack{
            
            HStack{
                TextField("Search by Name", text: $searchText).padding(.leading, 32)
            }.padding(.vertical, 7).padding(.horizontal, 10).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(15).padding()
            .onTapGesture(perform: {
                isSearching = true
            })
            .overlay(
                HStack{
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    if isSearching{
                        Button(action: {
                            self.searchText = ""
                        }, label: {Image(systemName: "xmark.circle.fill").padding(.vertical)})
                        
                    }
                }.padding(.horizontal, 32).foregroundColor(Color(.gray))
            )
            
            /*
            if isSearching{
                Button(action: {
                    isSearching = false
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label:
                {
                    Text("Cancel").padding(.trailing).padding(.leading, -12)
                
                }).buttonStyle(PlainButtonStyle()).foregroundColor(AppTheme().themeColorPrimary).transition(.move(edge: .trailing)).animation(.easeInOut)
            }
            */
        
        
        }
    }
    
    var body: some View {
            
        ScrollView{
            self.searchBar
            SelectedFilterPillsView(filterModel: self.viewModel.filterModel).padding(.horizontal, 20)
            LazyVStack{
                
            
                Divider().padding(.leading, 30).padding(.vertical, 5)
                ForEach(self.viewModel.getTransactionsList().filter({$0.name!.localizedCaseInsensitiveContains(self.searchText) || searchText.isEmpty}), id: \.self) { transaction in
                    
                    TransactionRow(coordinator: self.viewModel.coordinator!, transaction : transaction, transactionService: self.transactionService).padding(.horizontal).padding(.bottom, 10)
                    
                }
            }
                
            
            

        }.listStyle(SidebarListStyle())
            .navigationBarTitle(Text("Transactions"))
        .navigationBarItems(
            
            leading:
            
                Button(action: {
                    //self.viewModel.coordinator?.showFilterEditView(filterModel: self.viewModel.filterModel)
                }){
                    TransactionsRefreshIconView()
                }
            
            
            ,trailing:
            
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


