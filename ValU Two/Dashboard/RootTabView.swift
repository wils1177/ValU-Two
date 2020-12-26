//
//  RootTabView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 12/8/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView{
            Text("Summary").tabItem {
                Image(systemName: "creditcard")
                Text("Summary")
            }
            Text("Another Test").tabItem {
                Image(systemName: "list.dash")
                Text("Menu")
            }
        }
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
