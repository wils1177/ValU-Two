//
//  TransactionRuleDetail.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/6/22.
//  Copyright © 2022 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct TransactionRuleDetailView: View {
    
    
    @ObservedObject var viewModel : TransactionRuleViewModel
    
    @State var showDelete = false
    
    var coordinator : SettingsFlowCoordinator?
    
    init(viewModel : TransactionRuleViewModel){
        self.viewModel = viewModel
        UITextView.appearance().backgroundColor = .systemGroupedBackground
    }
    
    private var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 11),
            GridItem(.flexible(), spacing: 11),
        GridItem(.flexible(), spacing: 11)
        ]
    
    var body: some View {
        ScrollView{
            
            
            HStack(){
                Text("If a transaction's name contains:").font(.system(size: 20, design: .rounded)).bold().padding(.top)
                Spacer()
            }.padding(.leading)
            
            
            TextEditor(text: self.$viewModel.currentName).font(Font.system(size: 24, weight: .semibold)).frame(height: 55, alignment: .center).frame(minWidth: 0, maxWidth: 400, minHeight: 100, maxHeight: 600).multilineTextAlignment(.center).padding(.horizontal).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).padding(.horizontal).padding(.bottom)
            
            HStack(){
                Text("Then, it will be assigned to:").font(.system(size: 20, design: .rounded)).bold().padding(.top)
                Spacer()
            }.padding(.leading)
            
                
                LazyVGrid(      columns: columns,
                                alignment: .center,
                                spacing: 10,
                                pinnedViews: [.sectionHeaders, .sectionFooters]
                ){
                    
                    ForEach(self.viewModel.spendingCategories, id: \.self){entry in
                        
                        EditCategoryRowView(category: entry, viewModel: self.viewModel)
                                        
                    }
                }.padding(.horizontal)
            
            if self.viewModel.transactionRule != nil{
                Button(action: {
                    self.showDelete.toggle()
                }) {
                    HStack{
                        Spacer()
                        Image(systemName: "trash").font(.system(size: 21, weight: .regular)).foregroundColor(AppTheme().themeColorPrimary)
                        Text("Delete Transaction Rule").fontWeight(.semibold).foregroundColor(Color(.red))
                        Spacer()
                    }
                    
                }.buttonStyle(PlainButtonStyle()).padding().background(Color(.red).opacity(0.15)).cornerRadius(20).padding()
            }
            
            
                
            
            

        }
        .navigationBarTitle("Rule", displayMode: .large)
        .navigationBarItems(trailing:
            
            Button(action: {
            self.viewModel.submit()
            }){
                NavigationBarTextButton(text: "Save")
            }
            
            
            
        )
        .alert(isPresented:self.$showDelete) {
            Alert(title: Text("Are you sure you want to delete this rule?"), message: Text("It cannot be recovered"), primaryButton: .destructive(Text("Delete")) {
                self.viewModel.deleteRule(id: self.viewModel.transactionRule!.id!)
            }, secondaryButton: .cancel())
        }
    }
}


