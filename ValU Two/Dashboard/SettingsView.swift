//
//  SettingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel = SettingsViewModel()
    @State private var showLink = false
    @State var loadingAccounts = false
    var linkWrapper : PlaidLinkWrapper?
    
    init(){
        self.linkWrapper = PlaidLinkWrapper(viewModel: self.viewModel)
    }
    
    var body: some View {
        NavigationView{
            Form{
                
                
                
                
                Section(header: Text("Institutions")) {
                    
                    ForEach(self.viewModel.viewData, id: \.self){ item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Button(action: {
                                print("do nothing")
                            }) {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    
                    
                    HStack{
                        
                        Button(action: {
                            self.showLink = true
                        }) {
                            Text("Connect More Accounts")
                        }.sheet(isPresented: self.$showLink,
                        onDismiss: {
                            self.showLink = false
                            self.linkWrapper?.dismissLink()
                        }, content: {
                            self.linkWrapper
                            })
                        Spacer()
                    }
                }
            }
        }.navigationBarTitle("Settings")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
