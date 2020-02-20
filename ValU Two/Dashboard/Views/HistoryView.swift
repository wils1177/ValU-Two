//
//  HistoryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        
            ScrollView(.vertical, content: {
                VStack(alignment: .leading){
                    
                    HistoryEntryView().padding(.top)
                    HistoryEntryView()
                    HistoryEntryView()
                    Spacer()
                    
                    
                }
                
                
            })
                
                .navigationBarTitle("History")
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
