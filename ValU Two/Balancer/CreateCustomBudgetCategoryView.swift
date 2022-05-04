//
//  CreateCustomBudgetCategoryView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 7/6/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct CreateCustomBudgetCategoryView: View {
    
    @State var nameText = ""
    

    @State var selectedIcon = "🐵"
    
    
    @State var animalsAndNature = ["🐵", "🐶", "🐈", "🦁", "🦄", "🐮", "🐷", "🐻", "🦇", "🦃", "🐔", "🐤", "🐲", "🐳", "🐝", "🦠", "🌹", "🪴", "🌲", "☘️", "🦀", "🌎", "🌕", "☀️", "⭐", "⛅", "🌧️", "🌈", "☂️", "⚡", "❄️", "🎄", "🔥", "💧"]
    
    @State var foodAndDrink = ["🍇", "🍉", "🍋", "🍌", "🍍", "🍎", "🍓", "🥑", "🌶️", "🥨", "🥞", "🧀", "🍗", "🍟", "🍔", "🌮", "🌭", "🥚", "🍙", "🍣", "🍨", "🍩", "🍫", "☕", "🫖", "🍷", "🍸", "🍻", "🍹", "🥤", "🍽️", "🧊", "🍴"]
    
    @State var activity = ["🧗", "⛷️", "🏂", "🏌️", "🏄", "🚣", "🏊", "⛹️‍♂️", "🏋️‍♂️", "🚴", "🧘", "🎟️", "🏆", "⚽", "⚾", "🏀", "🏐", "🏈", "🎾", "🥏", "🎳", "🏒", "🥊", "⛳", "⛸️", "🎣", "🎯", "🎮", "🎲", "🧩", "🎭", "🎤", "🥁",
        "🎺", "🏹", "🎸", "🧶", "🎰", "🏸", "🏅"]
    
    
    @State var travelAndPlaces = ["🏔️", "🌋", "🏕️", "🏖️", "🏜️", "🏟️", "🏘️", "🏠", "🏢", "🏨", "🏥", "🏪", "🏫", "⛪", "🕌", "🛕", "🕍", "⛺", "🌄", "🛝", "🚂", "🚃", "🚃", "🚌", "🚕", "🚗", "🚘", "🛻", "🏎️", "🏍️", "🛵", "🚲", "🛴",
        "⛽", "⚓", "🛳️", "✈️", "🪂", "🛰️", "🚀",
        "⛱️", "🗿", "🪐", "⛵", "🚤", "🛞", "🚜", "🚚", "🏎️", "🚎", "🚇", "🎢"]
    
    @State var otherObjects = ["🛀", "🦽", "💈", "🛢️", "🛎️", "🧳", "⌛", "⏰", "🌡️", "🎈", "🎉", "🎁", "🤿", "🕹️", "🔮", "🪁", "🛍️", "💎", "📱", "☎️", "🔋", "💻", "💿", "🎥", "📺", "📷", "🔍", "💡", "📕", "📚", "💰", "💳", "📦",
        "✏️", "📎", "✂️", "🔑", "⚔️", "🔧", "🪛",
        "⚙️", "💊", "🧯", "🛒", "🧪", "🧲", "📡", "🪞", "🧺", "🧹", "🚰", "🚽",
        "🔗", "✉️", "🛁", "🧻", "💉", "🗺️", "📰", "🪣", "🚬", "🧱", "💣", "🔦"]
    
    
    @State var clothing = ["👓", "👕", "🎒", "👜", "👚", "🧳", "👔", "👟", "🧢", "💄", "👗", "🧣", "🌂", "🦺", "👙", "👡", "🧦", "🪖", "🧥", "🕶️", "👖", "👛", "👞", "👒", "💍"]
    
    
    @State var selectedSection = 0
    @State var showAlertForNoName = false
    
    var submitCallBack : (String, String) -> ()
    
    init(submitCallBack: @escaping (String, String) -> (), category: SpendingCategory? = nil){
        
        self.submitCallBack = submitCallBack
        
        if category != nil{
            _selectedIcon = State(initialValue: category!.icon!)
            _nameText = State(initialValue: category!.name!)
        }
        
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    func getSelectedIcon() -> String{
        return self.selectedIcon
    }
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                
                
                VStack{
                    Text(self.getSelectedIcon()).font(.system(size: 75)).padding(.top, 30).padding(.bottom, 5)
                    

                    
                    TextField("Name", text: self.$nameText).font(Font.system(size: 23, weight: .semibold)) .multilineTextAlignment(.center).frame(height: 28, alignment: .center).padding().background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).padding()
                }.padding(.bottom, 30)
                
                HStack{
                    Text("Choose an Icon").font(.system(size: 22, design: .rounded)).bold()
                    Spacer()
                }.padding(.horizontal)
                
                
                Picker("", selection: $selectedSection) {
                    Text("Nature").tag(0)
                    Text("Food").tag(1)
                    Text("Activity").tag(2)
                    Text("Travel").tag(3)
                    Text("Clothes").tag(4)
                    Text("Other").tag(5)
                            }
                .pickerStyle(.segmented).padding(.bottom, 15).padding(.horizontal)
                
                if selectedSection == 0{
                    EmojiSelectionGridView(icons: self.$animalsAndNature, selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }
                else if selectedSection == 1{
                    EmojiSelectionGridView(icons: self.$foodAndDrink, selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }
                else if selectedSection == 2{
                    EmojiSelectionGridView(icons: self.$activity,  selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }
                else if selectedSection == 3{
                    EmojiSelectionGridView(icons: self.$travelAndPlaces,  selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }
                else if selectedSection == 4{
                    EmojiSelectionGridView(icons: self.$clothing, selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }
                else if selectedSection == 5{
                    EmojiSelectionGridView(icons: self.$otherObjects, selectedIcon: self.$selectedIcon).padding(5).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20)
                        .padding(.horizontal)
                }

                
            }.navigationBarTitle("Category", displayMode: .inline).navigationBarItems(
                         
                leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    self.presentationMode.wrappedValue.dismiss()
                        }){
                        ZStack{
                            
                            NavigationBarTextButton(text: "Cancel")
                        }
                }
                    ,trailing: Button(action: {
                        
                        if self.nameText != ""{
                            
                            submitCallBack(self.getSelectedIcon(), self.nameText)
                            
                    
                            self.presentationMode.wrappedValue.dismiss()
                        }else{
                            self.showAlertForNoName = true
                        }
                        
                        
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Add")
                    }
            })
            
            
            .alert(isPresented: $showAlertForNoName) {
                Alert(title: Text("You need a name!"), message: Text("Please give a name to your new category!"), dismissButton: .default(Text("I'll fix it!")))
                }
            
        }
            
            
        }
        
    
}


