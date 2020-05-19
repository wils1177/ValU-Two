//
//  LoadedAccountsList.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct LoadedAccountsList: View {
    
    var accounts : [AccountData]
    
    
    
    var body: some View {
        
        ScrollView(.horizontal){
            HStack{
                ForEach(self.accounts, id: \.self){ account in
                    SwiftUIAccountCardView(account: account).padding(.horizontal)
                }.padding(.leading)
            }
        }

    }
}

