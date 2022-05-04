//
//  ConnectToBankView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 11/16/19.
//  Copyright © 2019 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct ConnectToBankView: View {
    
    var presentor : LoadingAccountsPresentor?
    var itemService : ItemManagerService
    @ObservedObject var viewData : LoadingAccountsViewData
    
    init(presentor: LoadingAccountsPresentor, itemManager: ItemManagerService, viewData: LoadingAccountsViewData){
        self.presentor = presentor
        self.itemService = itemManager
        self.viewData = viewData
    }
    
    var myConnectionsView : some View{
        MyConnectionsView(service: self.itemService, presentor: self.presentor!)
    }
    
    var noConnectionsView : some View{
        VStack(alignment: .center){
            
           Spacer()
            
            Image(systemName: "atom")
                .font(.system(size: 70))
                .font(.largeTitle.weight(.heavy))
                .symbolRenderingMode(.hierarchical)
                .foregroundColor(globalAppTheme.themeColorPrimary).padding(.bottom, 10)
            
            Text("Connect to your bank").font(.system(size: 32, design: .rounded)).fontWeight(.heavy).multilineTextAlignment(.center)
            
            Text("Budget app uses a connection to your bank to automatically import and categorize your spending.").font(.system(size: 18, design: .rounded)).fontWeight(.semibold).foregroundColor(Color(.lightGray)).multilineTextAlignment(.center).padding(.top)
            
            Spacer()
            
            if self.viewData.viewState == LoadingAccountsViewState.SettingUpLink{
                
                ActionButtonLarge(text: "Start Connecting", color: globalAppTheme.themeColorPrimary.opacity(0.3), textColor: globalAppTheme.themeColorPrimary, isLoading: true).padding()
                
            }
            else{
                Button(action: {
                    //Button Action
                    self.presentor?.launchPlaidLink()
                    }){
                    
                        
                        ActionButtonLarge(text: "Start Connecting", color: globalAppTheme.themeColorPrimary.opacity(0.3), textColor: globalAppTheme.themeColorPrimary).padding()
                    
                    
                }
            }
            
            
            
        }.padding(.horizontal).navigationBarHidden(true)
    }
    
    
    var body: some View {
        
        VStack{
            noConnectionsView
        }
        
    }
}


