//
//  MyConnectionsView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/15/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct MyConnectionsView: View {
    
    @ObservedObject var service : ItemManagerService
    var coordinator : PlaidLinkDelegate
    
    
    
    
    var actionButton : some View{
        Button(action: {
            //Button Action
            self.coordinator.launchPlaidLink()
            }){
            HStack{
                Spacer()
                ZStack{
                    Text("Add More").font(.subheadline).foregroundColor(.white).bold().padding()
                }
                Spacer()
            }.background(AppTheme().themeColorPrimary).cornerRadius(10).shadow(radius: 10).padding().padding(.horizontal).padding(.bottom)
            
            
        }
    }
    
    
    var body: some View {
        
        ScrollView{
            VStack{
                
                ForEach(self.service.getItems(), id: \.self){ item in
                    ConnectionCard(name: self.service.getNameOfItem(item: item), item: item, service: self.service).padding(.horizontal)
                    
                }.padding(.top)
                
                
                Spacer().padding(.bottom).padding(.bottom)
                actionButton
            }//.alert(isPresented: self.$service.showError) {
              //  Alert(title: Text("Could not Delete Connection"), message: Text("Try Again Later"), dismissButton: .default(Text("OK")))

            //}
            
        }.navigationBarTitle("Connections")
        
        
    }
}

struct ConnectionCard: View {
    
    var name : String
    var item : ItemData
    @ObservedObject var service : ItemManagerService
    @State var showingAlert = false
    
    var body: some View {
        
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(self.name).font(.headline).lineLimit(3)
                    Text("Accounts activley connected").foregroundColor(Color(.gray)).font(.subheadline).padding(.top, 5)
                }
                
                Spacer()
                Button(action: {
                    //Button Action
                    self.showingAlert = true
                    }){
                    Image(systemName: "trash").imageScale(.large).foregroundColor(AppTheme().themeColorPrimary)
                }.alert(isPresented:self.$showingAlert) {
                    Alert(title: Text("Are you sure you want to delete this connection?"), message: Text("All associated data will be deleted"), primaryButton: .destructive(Text("Delete")) {
                        self.service.deleteItem(itemId: self.item.itemId!)
                    }, secondaryButton: .cancel())
                }
                
            }
            
            }.padding().background(Color(.systemGroupedBackground)).cornerRadius(15)
    }
}


