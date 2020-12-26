//
//  EditCategoriesView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/20/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct EditCategoriesView: View {
    
    @ObservedObject var viewModel : EditCategoryViewModel
    
    @State var saveRule = true
    
    init(viewModel : EditCategoryViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationView{
            VStack{
                        
                         
                         List(){
                            
                            
                            
                             HStack{
                                
                                Text("You can select multiple categories for your transaction to count towards!").foregroundColor(Color(.lightGray))
                                 Spacer()
                             }.padding(.bottom).padding(.top, 5)
                            
                             
                             
                             HStack{
                                Image(systemName: "bookmark").padding(.horizontal, 8)
                                 Toggle(isOn: $viewModel.saveRule) {
                                     Text("Remember changes")
                                 }.padding(.trailing, 5)
                                }.padding(10).background(Color(.white)).cornerRadius(10)
                            
                            HStack{
                                Text("When selected, ValU will remeber your choices for future transactions with the same name.").font(.footnote).foregroundColor(Color(.lightGray))
                            }.padding(.horizontal, 10).padding(.bottom, 10)
                             
                            if self.viewModel.transaction.categoryMatches!.allObjects.count > 0{
                                CurrentlySelectedView(transaction: viewModel.transaction, viewModel: self.viewModel)
                            }
                            
                            
                            ForEach(self.viewModel.spendingCategories, id: \.self){ category in
                                EditCategoryCard(category: category, viewModel: self.viewModel)
                            }
                            
                         }.listStyle(SidebarListStyle())
            }.navigationBarTitle("Change Category", displayMode: .large)
            .navigationBarItems( trailing: Button(action: {
                                 self.viewModel.submit()
                             }){
            
                                 Text("Done").font(.subheadline).foregroundColor(.black).padding(7)
                                         
            })
        }
        
            
        
        //.background(LinearGradient(gradient:  Gradient(colors: [.blue, .white]), startPoint: .topTrailing, endPoint: .center))
                
        
        
    }
    
}



//struct EditCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
 //       EditCategoriesView(viewModel: nil)
 //   }
//}
