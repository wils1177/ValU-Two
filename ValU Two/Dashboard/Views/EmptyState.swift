//
//  EmptyState.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

struct EmptyState: View {
    
    var errorMessage : String
    
    init(errorMessage : String){
        self.errorMessage = errorMessage
    }
    
    
    var body: some View {
        VStack{
            Spacer()
            
            Text(self.errorMessage).font(.title).bold().lineLimit(nil).padding().multilineTextAlignment(.center).padding(.bottom, 70)
            
            Spacer()
        }
        
        
    }
}
