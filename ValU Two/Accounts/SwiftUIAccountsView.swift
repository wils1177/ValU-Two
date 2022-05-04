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
    
    func getBalance(account: AccountData) -> String{
        if account.type == "credit"{
            return String(Int(account.balances!.current))
        }
        else{
            return String(Int(account.balances!.available))
        }
    }
    
    var body: some View {
        VStack(spacing: 5){
            
            
            /*
            HStack{
                Text("Accounts").font(.system(size: 22, design: .rounded)).bold().bold()
                Spacer()
                
            }.padding(.horizontal).padding(.bottom, 5)
            */
            
            
            
            VStack{
                
                ForEach(self.accounts, id: \.self){ account in
                    Button(action: {
                        // What to perform
                        self.coordinator?.showAccountDetail(account: account)
                    }) {
                        // How the button looks like
                        
                        HStack{
                            SwiftUIAccountCardView(account: account, isSmall: true)
                            VStack(alignment: .leading){
                                Text(account.name!).font(.system(size: 16, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.gray)).lineLimit(1)
                                
                                Text(CommonUtils.makeMoneyString(number: Int(getBalance(account: account))!)).font(.system(size: 18, design: .rounded)).fontWeight(.semibold)
                                
                            }.padding(.leading, 3)
                            
                            Spacer()
                            if self.coordinator != nil {
                                Image(systemName: "chevron.right").font(.system(size: 13, weight: .bold, design: .rounded)).foregroundColor(Color(.lightGray))
                            }
                            
                        }.padding(.vertical, 6)
                            
                        
                    }.buttonStyle(PlainButtonStyle())
                    
                    if account.accountId != accounts.last!.accountId{
                        Divider().padding(.leading, 65)
                    }
                    else{
                        Spacer().frame(width: 15, height: 3)
                    }
                    
                }
                
            }.padding(.horizontal, 15).padding(.vertical, 10).background(Color(.tertiarySystemBackground)).cornerRadius(25).padding(.horizontal, 10).padding(.bottom)
            
            /*
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
            */
            

            
            
            
            
            
        }
        
    }
}


