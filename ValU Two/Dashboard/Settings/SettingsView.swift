//
//  SettingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SpendingCategoryLabelView : View{
    
    var name : String
    var icon : String
    
    var body : some View{
        HStack(spacing:2){
            
            Text(self.icon).font(.system(size: 12))
            Text(self.name).font(.system(size: 12, design: .rounded)).fontWeight(.heavy).foregroundColor(Color(.gray)).lineLimit(1)
        }.padding(.horizontal, 3).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(9)
    }
}

struct ItemRowView: View{
    
    @State var showingAlert = false
    @ObservedObject var model : ItemDeleteModel
    
    
    var body : some View{
        
        
            HStack{
                Text(self.model.name)
                Spacer()
                
                if !model.removing{
                    Button(action: {
                        self.showingAlert.toggle()
                        print("show alert")
                    }) {
                        Image(systemName: "trash")
                    }.buttonStyle(PlainButtonStyle())
                    
                        .alert(isPresented:self.$showingAlert) {
                            Alert(title: Text("Are you sure you want to delete this connection?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                                self.model.deleteItem()
                            }, secondaryButton: .cancel())
                        }
                }
                
                else{
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                }
                
            }
            
            
        
        
    }
}

struct SettingsView: View {
    
    @ObservedObject var viewModel : SettingsViewModel
    @State private var showLink = false
    @State var loadingAccounts = false
    
    

    
    init(viewModel: SettingsViewModel){
        print("settings view init")
        self.viewModel = viewModel
    }
    

    
    
    

    
    var body: some View {
                
                
                
            
            Form{
                
                Section(header: Text("Your Bank Connections")){
                    
                    ForEach(self.viewModel.items!, id: \.self){ item in
                        ItemRowView(model: ItemDeleteModel(item: item, parent: self.viewModel))
                    }
                    
                    
                    HStack{
                        
                        Button(action: {
                            self.viewModel.connectAccounts()
                        }) {
                            Text("Connect More Accounts")
                        }
                        //Spacer()
                    }
                }
                
                Section(header: Text("Transaction Rules"), footer: Text("With transaction rules, ValU Two can remember what categories should be assigned to transactions.")){
                    
                    ForEach(self.viewModel.rules, id: \.self){ rule in
                        
                        Button(action: {
                            // What to perform
                            self.viewModel.coordinator?.showTransactionRuleDetail(rule: rule)
                        }) {
                            HStack{
                                Text(rule.name!)
                                Spacer()
                                ForEach(rule.spendingCategories!.allObjects as! [SpendingCategory], id: \.self){ category in
                                    
                                    SpendingCategoryLabelView(name: category.name!, icon: category.icon!)
                                    
                                    
                                }
                                
                                
                            }
                        }
                        
                        
                        
                    }
                    
                    Button(action: {
                        self.viewModel.coordinator?.newTransactionRule()
                    }) {
                        Text("Create New Transaction Rule")
                    }
                    
                }
                    
                    
                    
                    
                
            }
            
 
            .navigationBarTitle("Settings", displayMode: .large).navigationBarItems(trailing:
                
                Button(action: {
                    self.viewModel.dismiss()
                }){
                    NavigationBarTextButton(text: "Done")
                }
                
                
                
            )
        
        
    }
}


