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
    var onDismiss: () -> ()
    
    @State var saveRule = true
    
    init(viewModel : EditCategoryViewModel, onDismiss: @escaping () -> ()){
        self.viewModel = viewModel
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        
        
        
        ZStack{
            
            VStack{
                //.padding(.bottom).padding(.bottom)
                HStack{
                    Text("Change Category").font(.largeTitle).bold().padding(.leading)
                    Spacer()
                }.padding(.top).padding(.top)
                
                
                
                
                ScrollView(){
                    HStack{
                        Text("You can select multiple cateogire for your transaction to count towards!").font(.headline).bold().padding()
                        Spacer()
                    }.padding(.bottom)
                    
                    
                    HStack{
                        Toggle(isOn: $viewModel.saveRule) {
                            Text("Remember for similar transactions")
                        }.padding()
                    }
                    
                    
                    
                    
                    CurrentlySelectedCategoriesView(viewModel: viewModel).padding(.bottom)
                    CategoryCardListView(viewModel: viewModel)
                    }
            }.background(LinearGradient(gradient:  Gradient(colors: [.blue, .white]), startPoint: .topTrailing, endPoint: .center))
            
            
            HStack{
                Spacer()
                VStack{
                Spacer()
                Button(action: {
                    self.viewModel.submit()
                    self.onDismiss()
                }){
                    
                    HStack{
                        
                        ZStack{
                            Text("Done").font(.subheadline).foregroundColor(.black).bold().padding()
                            
                            
                            
                        }
                        
                    }.background(LinearGradient(gradient:  Gradient(colors: [.white, .white]), startPoint: .topTrailing, endPoint: .center)).cornerRadius(30).shadow(radius: 20).padding()
                    
                    
                }
                }
            }
            
        }
        
        
    }
    
}

//struct EditCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
 //       EditCategoriesView(viewModel: nil)
 //   }
//}
