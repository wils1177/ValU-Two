//
//  SwiftUIAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/11/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SwiftUIAccountsView: View {
        
    var accounts : [AccountData]
    var coordinator: MoneyTabCoordinator?
    
    init(coordinator: MoneyTabCoordinator?){
        accounts = AccountsViewModel().accounts
        self.coordinator = coordinator
    }
    
    init(accounts: [AccountData]){
        self.accounts = accounts
    }
    
    var body: some View {
        VStack(spacing: 5){
            
            /*
            HStack{
                Text("Accounts").font(.system(size: 22)).bold().bold()
                Spacer()
                
            }
            */
            
            VStack(alignment: .center, spacing: 5.0) {
                        ForEach(self.accounts, id: \.self){ account in
                            

                            Button(action: {
                                // What to perform
                                self.coordinator?.showAccountDetail(account: account)
                            }) {
                                // How the button looks like
                                
                                SwiftUIAccountCardView(account: account).shadow(radius: 5).padding()
                                    
                                
                            }.buttonStyle(PlainButtonStyle())
                        
                            
                            

                            
                        }
                }
            
            

            
            
            
            
            
        }
        
    }
}


