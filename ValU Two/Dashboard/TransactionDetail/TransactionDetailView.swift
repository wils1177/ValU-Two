//
//  TransactionDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI
import MapKit



struct TransactionDetailView: View {
    
    @ObservedObject var viewModel : TransactionDetailViewModel
    @ObservedObject var transaction : Transaction
    
    
    init(viewModel: TransactionDetailViewModel, transaction: Transaction){
        self.viewModel = viewModel
        self.transaction = transaction

    }
    
    var headerTitle : some View{
        VStack{
            HStack{
                Text(self.viewModel.viewData!.name).font(.title).bold()
                Spacer()
            }.padding(.horizontal).padding(.top)
                       
                       
                       
                       
            HStack{
                Text(viewModel.viewData!.accountName)
                Spacer()
            }.padding(.horizontal)
                       
            HStack{
                Text(viewModel.viewData!.date)
                Spacer()
            }.padding(.horizontal)
        }
    }
    
    var amountSection : some View{
        VStack{
            HStack{
                Text("Original Amount").font(.headline).bold()
                Spacer()
                Text(self.viewModel.viewData!.amount).font(.headline)
            }
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 1)
    }
    
    var rawCategories: some View{
        VStack{
            Text(viewModel.transaction.transactionId!)
        }
    }
    
    var settingsSection: some View{
        VStack{
            HStack{
                Toggle(isOn: self.$viewModel.isHidden) {
                    Text("Hide from Budget").font(.headline).bold()
                        Spacer()
                }.onTapGesture {
                  // Any actions here.
                    print("Status Changed")
                    self.viewModel.toggleHidden()
                }
            }
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 1)
    }
    

    
    var categorySection : some View{
        VStack{
            ForEach(self.transaction.categoryMatches!.allObjects as! [CategoryMatch], id: \.self) { category in
                VStack{
                    CategoryAmountRowView(viewData: category, viewModel: self.viewModel)
                    
                    if category.id != (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).last!.id{
                        Divider()
                    }
                    
                }
                
            }
        }.padding().background(Color(.white)).cornerRadius(10).shadow(radius: 1)
    }

    
    var body: some View {
        
        ScrollView{
            VStack{
                
            HStack{
                self.headerTitle
                Spacer()
                TransactionIconView(icons: viewModel.viewData!.icons).padding().padding().padding(.horizontal).scaleEffect(2)
            }.padding(.top)
            
            Divider().padding(.horizontal)
                self.amountSection.padding()
            
                
            
                if (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).count > 0{
                
                HStack{
                    Text("Categories").font(.headline).bold()
                    Spacer()
                }.padding(.horizontal)
                
                self.categorySection.padding(.horizontal)
            }
                
            self.settingsSection.padding()
            
            HStack{
                
                Button(action: {
                    //Button Action
                    self.viewModel.coordinator?.showEditCategory(transaction: self.viewModel.transaction)
                    }){
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Change Categories").font(.subheadline).foregroundColor(.white).bold().padding()
                        }
                        Spacer()
                    }.background(Color(.systemTeal)).cornerRadius(20).shadow(radius: 10).padding()
                    
                    
                }
                
                
                
            }
                
            HStack{
                
                Button(action: {
                    //Button Action
                    }){
                    HStack{
                        Spacer()
                        ZStack{
                            Text("Someone Paid Me Back").font(.subheadline).foregroundColor(.black).bold().padding()
                        }
                        Spacer()
                    }.background(Color(.white)).cornerRadius(20).shadow(radius: 10).padding(.horizontal)
                    
                    
                }
                
                
                
            }
                
                
            
            Spacer()
        }
        
        
        }
        
    }
}






struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0))
    }
}
