//
//  FixNowCard.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/26/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct FixNowCard: View {
    
    @ObservedObject var service : FixNowService
    var itemId : String
    
    var startState : some View{
        HStack{
            Button(action: {
                // What to perform
                self.service.showLinkUpdateMode(itemId: self.itemId)
            }) {
                // How the button looks like
                fixNowButton
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
    var fixNowButton : some View{
        HStack{
            
            Image(systemName: "exclamationmark.triangle.fill").foregroundColor(Color(.systemYellow)).imageScale(.large).padding(.leading, 5)
            Spacer()
            Text("Your bank needs to re-verify your identity").foregroundColor(Color(.gray)).font(.footnote).padding(.leading, 5)
            Spacer()
            Text("Fix Now").foregroundColor(AppTheme().themeColorPrimary).font(.callout)
            
            }
    }
    
    var loadingState : some View{
        HStack{
            Text("Loading...").foregroundColor(Color(.gray)).font(.footnote).padding(.leading, 5)
            Spacer()
        }
    }
    
    var failState : some View{
        HStack{
            Text("Could not load. Try again? ")
            
            Button(action: {
                // What to perform
                self.service.showLinkUpdateMode(itemId: self.itemId)
            }) {
                // How the button looks like
                Text("Fix Now").foregroundColor(AppTheme().themeColorPrimary)
            }.buttonStyle(PlainButtonStyle())
        }
    }
    
    var body: some View {
        
        HStack{
            if self.service.state == FixNowLoadingState.start{
                startState
            }
            else if self.service.state == FixNowLoadingState.fail{
                failState
            }
            else if self.service.state == FixNowLoadingState.loading{
                loadingState
            }
        }.padding(10).background(Color(.white)).cornerRadius(15)
        
    }
}


