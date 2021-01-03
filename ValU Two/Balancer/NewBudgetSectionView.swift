//
//  NewBudgetSectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 6/28/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct NewBudgetSectionView: View {
    
    @State var nameText = ""
    
    @State var icons = [["flame", "paintbrush", "leaf", "bed.double", "heart"],
                         ["cross", "bus", "network", "bolt.horizontal.circle", "tv"],
                         ["macpro.gen3", "gamecontroller.fill", "ticket", "paperclip", "pianokeys"],
                         ["speedometer", "ruler", "hammer", "briefcase", "puzzlepiece"],
                         ["lock", "pin", "map", "film", "crown"],
                         ["eyes", "pencil", "eyeglasses", "die.face.3", "cloud.sun"],
                         ["moon", "sun.max", "phone", "envelope", "message"],
                         ["scribble", "newspaper", "book.closed", "sleep", "drop"]
    ]
        
    
    
    @State var colors = [0, 1, 2 ,3 , 4 ,5 ,
                         6, 7, 8, 9, 10, 11]
    
    @State var selectedIconRow = 0
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
            RoundedRectangle(cornerRadius: 25).frame(width: 120, height: 120).foregroundColor(colorMap[self.colors[selectedColorColumn]] as! Color)
            Image(systemName: self.icons[self.selectedIconRow][self.selectedIconColumn]).font(.system(size: 55)).foregroundColor(Color(.white))
            
        }
    }

    
    
    var body: some View {
        NavigationView{
            ScrollView{
                
                VStack(alignment: .center){
                    
                    
                    createdIconView.shadow(color: colorMap[self.colors[selectedColorColumn]], radius: 10).padding().padding(.top, 30)
                    
                    VStack{
                        HStack{
                            Text("Name").font(.title3).bold()
                            Spacer()
                        }.padding(.horizontal)
                        
                        TextField("Category Name", text: self.$nameText).font(Font.system(size: 20, weight: .semibold)).frame(height: 30, alignment: .center).padding().background(Color(.systemGroupedBackground)).cornerRadius(10).padding(.horizontal).padding(.bottom)
                    
 
                }.padding(.top, 40)
                
                VStack{
                    HStack{
                        Text("Color").font(.title3).bold()
                        Spacer()
                    }.padding(.horizontal)
                    ColorSelectionGridView(colors: self.$colors, selectedColumn: self.$selectedColorColumn).padding(10).background(Color(.systemGroupedBackground)).cornerRadius(15).padding(.horizontal).padding(.bottom)
                }
                
                VStack{
                    HStack{
                        Text("Icon").font(.title3).bold()
                        Spacer()
                    }.padding(.horizontal)
                    IconSelectionGridView(icons: self.$icons, selectedRow: self.$selectedIconRow, selectedColumn: self.$selectedIconColumn).padding().background(Color(.systemGroupedBackground)).cornerRadius(15).padding(.horizontal).padding(.bottom)
                }
                
                    
                    
                    
                
                
            }
            .navigationBarTitle("New Budget Section", displayMode: .inline).navigationBarItems(
                
                leading: Button(action: {
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        Text("Cancel")
                    }
            }
                ,trailing: Button(action: {
                        self.budgetSectionCreator.addSectionToBudget(name: self.nameText, icon: self.icons[self.selectedIconRow][self.selectedIconColumn], colorCode: self.colors[self.selectedColorColumn])
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        Text("Add")
                    }
            })
        }
        
    }
}


}
