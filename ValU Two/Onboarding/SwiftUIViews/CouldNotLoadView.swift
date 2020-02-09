//
//  CouldNotLoadAccountsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CouldNotLoadView: View {
    
    var errorMessage : String
    
    init(errorMessage : String){
        self.errorMessage = errorMessage
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(self.errorMessage).font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 70)
            
            Spacer()
        }.navigationBarTitle(Text("Welcome"),  displayMode: .large)
        .navigationBarHidden(true)
        
    }
}

struct CouldNotLoadAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        CouldNotLoadView(errorMessage: "Could Not Load Accounts. Please Try Again.")
    }
}
