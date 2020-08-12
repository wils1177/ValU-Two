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
    
    @State var icons = [["plus.magnifyingglass", "paintbrush", "pencil.and.ellipsis.rectangle", "purchased", "recordingtape", "recordingtape"],
                         ["sunset.fill", "suit.diamond", "sterlingsign.square", "star.slash.fill", "v.circle", "recordingtape"],
                         ["sunset.fill", "suit.diamond", "sterlingsign.square", "star.slash.fill", "v.circle", "recordingtape"]]
        
    
    
    @State var colors = [[0, 1, 2 ,3 , 4 ,5 ],
                         [6, 7, 8, 9, 10, 11]]
    
    @State var selectedIconRow = 0
    @State var selectedIconColumn = 0
    
    
    @State var selectedColorRow = 0
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
            Circle().frame(width: 100, height: 100).foregroundColor(colorMap[self.colors[selectedColorRow][selectedColorColumn]])
            Image(systemName: self.icons[self.selectedIconRow][self.selectedIconColumn]).font(.system(size: 55)).foregroundColor(Color(.white))
            
        }
    }

    
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .center){
                    
                    
                    createdIconView.shadow(radius: 10).padding()
                        
                    TextField("Category Name", text: self.$nameText).font(Font.system(size: 20, weight: .semibold)).frame(width: 300, height: 30, alignment: .center).padding().background(Color(.systemGroupedBackground)).cornerRadius(10)
                    
 
                }.padding(.top, 40)
                
                ColorSelectionGridView(colors: self.$colors, selectedRow: self.$selectedColorRow, selectedColumn: self.$selectedColorColumn).padding()
                
                IconSelectionGridView(icons: self.$icons, selectedRow: self.$selectedIconRow, selectedColumn: self.$selectedIconColumn)
                .padding()
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
                        self.budgetSectionCreator.addSectionToBudget(name: self.nameText, icon: self.icons[self.selectedIconRow][self.selectedIconColumn], colorCode: self.colors[self.selectedColorRow][self.selectedColorColumn])
                        self.coordinator?.dismissPresented()
                    }){
                    ZStack{
                        
                        Text("Add")
                    }
            })
        }
        
    }
}


