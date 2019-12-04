//
//  CouldNotLoadAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CouldNotLoadAccountsView: View {
    var body: some View {
        VStack{
            Spacer()
            
            Text("Accounts Failed to Load. You might want to retry.").font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 70)
            
            Spacer()
        }
        
    }
}

struct CouldNotLoadAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        CouldNotLoadAccountsView()
    }
}
