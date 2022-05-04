//
//  NewBudgetSectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct NewBudgetSectionView: View {
    
    @State var showAlertForNoName = false
    
    @State var nameText = ""
    
    @State var icons = ["flame.fill", "paintbrush.fill", "leaf.fill", "house.fill", "heart.fill",
                         "graduationcap.fill", "bus.fill", "globe.americas.fill", "ticket.fill", "fork.knife",
                         "macpro.gen3.fill", "gamecontroller.fill", "tag.fill", "paperclip", "pianokeys",
                         "cloud.sun.fill", "car.fill", "hammer.fill", "briefcase.fill", "brain",
                         "pawprint.fill", "ferry.fill", "map.fill", "film.fill", "crown",
                         "eyes", "scissors", "shippingbox.fill", "gift.fill", "cloud.sun",
                         "moon.fill", "pc", "phone.fill", "envelope.fill", "message",
                         "lightbulb.fill", "newspaper", "book.closed", "bandage.fill", "guitars.fill",
                        "mustache.fill", "building.2.fill"
    ]
        
    
    
    @State var colors = [0, 1, 2 ,3 , 4 ,5 ,
                         6, 7, 8, 9, 10, 11]
    
    @State var selectedIconColumn = 0
    
    
    @State var selectedColorColumn = 0
    
    
    
    var budget : Budget
    var budgetSectionCreator : BudgetSectionCreator
    var coordinator : BudgetEditableCoordinator?
    
    init(budget: Budget){
        self.budget = budget
        self.budgetSectionCreator = BudgetSectionCreator(budget: budget)
    }
    
    
    var createdIconView : some View {
        ZStack(alignment: .center){
            RoundedRectangle(cornerRadius: 40).frame(width: 120, height: 120).foregroundColor(colorMap[self.colors[selectedColorColumn]] as! Color)
            Image(systemName: self.icons[self.selectedIconColumn]).font(.system(size: 55)).foregroundColor(Color(.white))
            
        }
    }

    
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack(alignment: .center){
                    
                    
                    createdIconView.shadow(color: colorMap[self.colors[selectedColorColumn]], radius: 10).padding().padding(.top, 30)
                    
                VStack{
                    
                    
                    TextField("Name", text: self.$nameText).font(Font.system(size: 24, weight: .semibold)).frame(height: 65, alignment: .center).multilineTextAlignment(.center).padding(.horizontal).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).padding(.horizontal).padding(.bottom)
                    
 
                }
                
                VStack{
                    HStack{
                        Text("Color").font(.system(size: 22, design: .rounded)).bold()
                        Spacer()
                    }.padding(.horizontal)
                    ColorSelectionGridView(colors: self.$colors, selectedColumn: self.$selectedColorColumn).padding(10).background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).padding(.horizontal).padding(.bottom)
                }
                
                VStack{
                    HStack{
                        Text("Icon").font(.system(size: 22, design: .rounded)).bold()
                        Spacer()
                    }.padding(.horizontal)
                    IconSelectionGridView(icons: self.$icons, selectedColumn: self.$selectedIconColumn).padding().background(Color(.tertiarySystemGroupedBackground)).cornerRadius(20).padding(.horizontal).padding(.bottom)
                }
                
                    
                    
                    
                
                
            }
            .navigationBarTitle("New Budget Section", displayMode: .inline).navigationBarItems(
                
                leading: Button(action: {
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Cancel")
                    }
            }
                ,trailing: Button(action: {
                        
                    if self.nameText != ""{
                        self.budgetSectionCreator.addSectionToBudget(name: self.nameText, icon: self.icons[self.selectedIconColumn], colorCode: self.colors[self.selectedColorColumn])
                        self.coordinator?.dismissPresented()
                    }else{
                        self.showAlertForNoName = true
                    }
                    
                        
                    }){
                    ZStack{
                        
                        NavigationBarTextButton(text: "Add")
                    }
            })
                
            .alert(isPresented: $showAlertForNoName) {
                Alert(title: Text("You need a name!"), message: Text("Please give a name to your new budget!"), dismissButton: .default(Text("I'll fix it!")))
                }
        }
        
    }
}


}
