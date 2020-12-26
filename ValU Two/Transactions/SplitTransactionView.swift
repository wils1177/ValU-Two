//
//  SplitTransactionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 5/10/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SplitTransactionView: View {
    
    @State var toggle = false
    
    @State var splits = ["1 Person", "2 People", "3 People", "4 People", "5 People", "6 People", "7 People"]
    
    var body: some View {
        NavigationView{
                
                Form{
                    
                    Section{
                        HStack{
                           
                           Text("You can select multiple categories for your transaction to count towards!").foregroundColor(Color(.lightGray))
                            Spacer()
                        }.padding(.bottom).padding(.top, 5)
                    }
                    
                    Section{
                        HStack{
                            Image(systemName: "bookmark").padding(.horizontal, 8)
                            Toggle(isOn: $toggle) {
                                Text("Remember changes")
                            }.padding(.trailing, 5)
                        }
                        Text("When selected, ValU will remeber your choices for future transactions with the same name.").font(.footnote).foregroundColor(Color(.lightGray))
    
                    }.padding(10).background(Color(.white)).cornerRadius(10)
                    
                    
                    Section{
                        Picker(selection: $splits, label: Text("Test")) {
                            ForEach(0 ..< splits.count) {
                                Text(self.splits[$0])

                            }
                        }.pickerStyle(DefaultPickerStyle())
                    }
                }.navigationBarTitle("Split Transaction")
                
                
                
            
        }
        
        
    }
}


