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
        
        UISwitch.appearance().onTintColor = AppTheme().themeColorPrimaryUIKit
        
        print(transaction.location?.city)
        print(transaction.location?.address)
        print(transaction.location?.lat)
        print(transaction.location?.lon)
    }
    
    func dateToString(date: Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: date)
    }
    

    
    var headerTitle : some View{
        VStack(alignment: .center){
            
            TransactionIconViewLarge(icons: viewModel.getIcons(categories: self.transaction.categoryMatches?.allObjects as! [CategoryMatch])).padding(.horizontal).padding(.top, 10).padding(.bottom,10)
            
            HStack(){
                Spacer()
                Text(transaction.name!).font(.system(size: 29, design: .rounded)).fontWeight(.bold).multilineTextAlignment(.center)
                Spacer()
            }.padding(.horizontal)
                       
                       
                       
                       
            HStack{
                Spacer()
                Text(dateToString(date: self.transaction.date!)).font(.subheadline).foregroundColor(Color(.gray))
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
                Text(CommonUtils.makeMoneyString(number: self.transaction.amount)).bold()

            }
        }
    }
    
    var accountSection : some View{
        VStack{
            HStack{
                Text("Account")
                Spacer()
                Text(self.account?.name ?? "Unknown").bold().lineLimit(1)

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
                }.accentColor(AppTheme().themeColorPrimary)
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
                self.viewModel.coordinator?.showEditCategory(transaction: self.transaction)
                }){
                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 7){
                    Image(systemName: "ellipsis.circle.fill").imageScale(.large).foregroundColor(AppTheme().themeColorPrimary).padding(.top, 10)
                    Text("Edit Category").foregroundColor(AppTheme().themeColorPrimary).font(.caption).padding(.bottom, 5)
                    }
                    Spacer()
                }.padding(.horizontal).padding(.vertical, 5).background(Color(.tertiarySystemGroupedBackground).opacity(0.65)).cornerRadius(15).padding(.leading).padding(.trailing, 5)

            }
            
            Spacer()
            
            Button(action: {
                //Button Action
                self.viewModel.coordinator?.showSplitTransaction(transaction: self.viewModel.transaction)
                
                }){
                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 7){
                            Image(systemName: "divide.circle.fill").imageScale(.large).foregroundColor(AppTheme().themeColorPrimary).padding(.top, 10)
                        Text("Split").foregroundColor(AppTheme().themeColorPrimary).font(.caption).padding(.bottom, 5)
                        }
                    Spacer()
                }.padding(.horizontal).padding(.vertical, 5).background(Color(.tertiarySystemGroupedBackground).opacity(0.65)).cornerRadius(15).padding(.trailing).padding(.leading, 5)

            }
            
            
            
                
            
            
        }.padding(5)
        
        
        
    }
    

    
    var categorySection : some View{
        VStack(spacing: 0){
            ForEach(self.transaction.categoryMatches!.allObjects as! [CategoryMatch], id: \.self) { category in
                VStack(spacing: 0){
                    CategoryAmountRowView(viewData: category, viewModel: self.viewModel).padding(.bottom)
                    
                    
                    
                }
                
            }
        }.padding(.top)
    }

    
    var body: some View {
        
        ScrollView{
            VStack{
                
                self.headerTitle.padding(.top, 30)
                
            //Divider().padding(.horizontal)
                
                actionSection.padding(.top, 10)
                
                
                HStack{
                    Text("General").font(.system(size: 20, design: .rounded)).bold()
                    Spacer()
                }.padding(.top).padding(.horizontal).padding(.bottom, 5)
                
                VStack(){
                    self.amountSection.padding(.bottom, 10).padding(.horizontal)//.background(Color(.systemGroupedBackground).opacity(0.65)).cornerRadius(10).padding(.bottom, 10).padding(.horizontal)
                    Rectangle().frame(height: 3).foregroundColor(Color(.tertiarySystemGroupedBackground)).padding(.horizontal, 15).padding(.bottom, 10)
                    self.accountSection.padding(.bottom, 10).padding(.horizontal)//.background(Color(.systemGroupedBackground).opacity(0.65)).cornerRadius(10).padding(.bottom, 10).padding(.horizontal)
                    Rectangle().frame(height: 3).foregroundColor(Color(.tertiarySystemGroupedBackground)).padding(.horizontal, 15).padding(.bottom, 10)
                    self.settingsSection.padding(.bottom, 5).padding(.horizontal)//.background(Color(.systemGroupedBackground).opacity(0.65)).cornerRadius(10).padding(.bottom, 10).padding(.horizontal)
                    Rectangle().frame(height: 3).foregroundColor(Color(.tertiarySystemGroupedBackground)).padding(.horizontal, 15)
                }.padding(.top).padding(.horizontal)
                
                
            
                if (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).count > 0{
                
                HStack{
                    Text("Categories").font(.system(size: 20, design: .rounded)).bold()
                    Spacer()
                }.padding(.horizontal).padding(.top)
                
                self.categorySection.padding(.horizontal).padding(.horizontal, 5).padding(.bottom, 30)
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
