//
//  SettingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var viewModel : SettingsViewModel
    @State private var showLink = false
    @State var loadingAccounts = false
    @State var showingAlert = false
    
    init(viewModel: SettingsViewModel){
        print("settings view init")
        self.viewModel = viewModel
    }
    

    

    
    var body: some View {
            VStack{
                
                
                
            
            Form{
                
                Section(header: Text("Your Bank Connections")){
                    
                    
                    ForEach(self.viewModel.viewData, id: \.self){ item in
                        HStack{
                            Text(item.name).padding(.leading)
                            Spacer()
                            Button(action: {
                                self.showingAlert = true
                            }) {
                                Image(systemName: "trash").padding(.trailing)
                            }
                        }.alert(isPresented:self.$showingAlert) {
                            Alert(title: Text("Are you sure you want to delete this connection?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                                self.viewModel.deleteItem(itemId: item.id)
                            }, secondaryButton: .cancel())
                        }
                    }
                    
                    HStack{
                        
                        Button(action: {
                            self.viewModel.connectAccounts()
                        }) {
                            Text("Connect More Accounts").padding(.leading)
                        }
                        //Spacer()
                    }
                }.padding(.top)
                    
                    
                    
                    
                
            }.alert(isPresented: self.$viewModel.showError) {
                Alert(title: Text("Could not Delete Connection"), message: Text("Try Again Later"), dismissButton: .default(Text("OK")))
             
                
            }
 
            }.navigationBarTitle("Settings").navigationBarItems(trailing:
                
                Button(action: {
                    self.viewModel.dismiss()
                }){
                ZStack{
                    
                    Text("Done")
                }
                }
                
                
                
            )
        
        
    }
}


