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
    
    init(){
        accounts = AccountsViewModel().accounts
    }
    
    init(accounts: [AccountData]){
        self.accounts = accounts
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Your Accounts").font(.title).padding()
                Spacer()
                
            }
            
            
            
        
            // statuses
            ScrollView(.horizontal, content: {
                
                HStack(spacing: 0) {
                    ForEach(self.accounts, id: \.self){ account in
                        
                        SwiftUIAccountCardView(account: account).padding()

                        
                    }
                }
            })
            
            
            
            
            
        }
        
    }
}

struct SwiftUIAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIAccountsView()
    }
}
