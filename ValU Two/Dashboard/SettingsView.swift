//
//  SettingsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/30/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView{
            Form{
                
                
                
                
                Section(header: Text("Institutions")) {
                    HStack{
                        Text("hey")
                        Spacer()
                        Button(action: {
                            print("do nothing")
                        }) {
                            Image(systemName: "trash")
                        }
                    }
                    HStack{
                        Button(action: {
                            print("do nothing")
                        }) {
                            Text("Connect More Accounts")
                        }
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
