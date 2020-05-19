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
    var account : AccountData?
    
    
    init(viewModel: TransactionDetailViewModel, transaction: Transaction, account: AccountData?){
        self.viewModel = viewModel
        self.transaction = transaction
        self.account = account
        
        
    }
    
    func dateToString(date: Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: date)
    }
    
    var headerTitle : some View{
        VStack(alignment: .center){
            
            TransactionIconView(icons: viewModel.getIcons(categories: self.transaction.categoryMatches?.allObjects as! [CategoryMatch])).padding().padding(.horizontal).scaleEffect(2).padding(.top, 10)
            
            HStack(){
                Spacer()
                Text(transaction.name!).font(.title).bold().multilineTextAlignment(.center)
                Spacer()
            }.padding(.horizontal)
                       
                       
                       
                       
            HStack{
                Spacer()
                Text((self.account?.name ?? "No Account") + " - " + dateToString(date: self.transaction.date!)).font(.subheadline).foregroundColor(Color(.gray))
                Spacer()
            }.padding(.horizontal)
            
            /*
            HStack{
                Spacer()
                Text(dateToString(date: self.transaction.date!)).font(.callout).foregroundColor(Color(.gray))
                Spacer()
            }.padding(.horizontal)
            */
        }
    }
    
    var amountSection : some View{
        VStack{
            HStack{
                Text("Original Amount")
                Spacer()
                Text(CommonUtils.makeMoneyString(number: self.transaction.amount))

            }
        }
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
                    Text("Hide from Budget")
                        Spacer()
                }
                //.onTapGesture {
                  // Any actions here.
                //    print("Status Changed")
                //    self.viewModel.toggleHidden()
                //}
            }
        }
    }
    
    var actionSection : some View{
        HStack{
            
            Button(action: {
                //Button Action
                self.viewModel.coordinator?.showEditCategory(transaction: self.viewModel.transaction)
                }){
                HStack{
                    Spacer()
                   VStack(alignment: .center){
                    Image(systemName: "ellipsis.circle.fill").imageScale(.large).foregroundColor(Color(.systemBlue)).padding(.top, 10)
                    Text("Edit Category").foregroundColor(Color(.systemBlue)).font(.caption).padding(.bottom, 5)
                    }
                    Spacer()
                }.padding(.horizontal).padding(.vertical, 5).background(Color(.white)).cornerRadius(10).padding(.leading).padding(.trailing, 5)

            }
            
            Spacer()
            
            Button(action: {
                //Button Action
                self.viewModel.coordinator?.showSplitTransaction(transaction: self.viewModel.transaction)
                }){
                HStack{
                    Spacer()
                       VStack(alignment: .center){
                            Image(systemName: "divide.circle.fill").imageScale(.large).foregroundColor(Color(.systemBlue)).padding(.top, 10)
                        Text("Split").foregroundColor(Color(.systemBlue)).font(.caption).padding(.bottom, 5)
                        }
                    Spacer()
                }.padding(.horizontal).padding(.vertical, 5).background(Color(.white)).cornerRadius(10).padding(.trailing).padding(.leading, 5)

            }
            
            
            
                
            
            
        }.padding(5)
        
        
        
    }
    

    
    var categorySection : some View{
        VStack(spacing: 0){
            ForEach(self.transaction.categoryMatches!.allObjects as! [CategoryMatch], id: \.self) { category in
                VStack(spacing: 0){
                    CategoryAmountRowView(viewData: category, viewModel: self.viewModel)
                    
                    if category.id != (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).last!.id{
                        Divider().padding(.leading).padding(.leading).padding(.vertical, 8)
                    }
                    
                }
                
            }
        }.padding(12).background(Color(.white)).cornerRadius(10)
    }

    
    var body: some View {
        
        ScrollView{
            VStack{
                
            self.headerTitle
                
            //Divider().padding(.horizontal)
                
                actionSection.padding(.top, 10)
                
                
                HStack{
                    Text("GENERAL").font(.caption).foregroundColor(Color(.gray))
                    Spacer()
                }.padding(.horizontal).padding(.top).padding(.horizontal).padding(.bottom, 5)
                
                VStack(){
                    self.amountSection.padding(.horizontal).padding(.top, 12)
                    Divider().padding(.leading, 20)
                    self.settingsSection.padding(.horizontal).padding(.bottom, 12)
                    }.background(Color(.white)).cornerRadius(10).padding(.horizontal).padding(.bottom)
                
                
            
                if (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).count > 0{
                
                HStack{
                    Text("CATEGORIES").font(.caption).foregroundColor(Color(.gray))
                    Spacer()
                }.padding(.horizontal).padding(.horizontal)
                
                self.categorySection.padding(.horizontal).padding(.bottom, 30)
            }
         
            Spacer()
        }
        
        
        }.background(Color(.systemGroupedBackground))
        
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
