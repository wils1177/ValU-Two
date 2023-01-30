//
//  TransactionDetailView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct TransactionDetailView: View {
    
    @ObservedObject var viewModel : TransactionDetailViewModel
    @ObservedObject var transaction : Transaction
    var account : AccountData?
    
    var transactionService = TransactionService()
    
    @State private var region : MKCoordinateRegion
    
    var showMap = false
    
    var annotationItems: [MyAnnotationItem]?
    
    init(viewModel: TransactionDetailViewModel, transaction: Transaction, account: AccountData?){
        self.viewModel = viewModel
        self.transaction = transaction
        self.account = account
        
        UISwitch.appearance().onTintColor = AppTheme().themeColorPrimaryUIKit
        
        print(transaction.location!.lat)
        if transaction.location != nil && transaction.location!.lat != 0.0 && transaction.location!.lon != 0.0{
            var coord = CLLocationCoordinate2D(latitude: transaction.location!.lat, longitude: transaction.location!.lon)
            self.region = MKCoordinateRegion(center: coord, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            self.showMap = true
            self.annotationItems = [MyAnnotationItem(coordinate: coord)]
        }
        else{
            self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        }
        print(self.transaction.name)
        print(self.transaction.plaidCategories)
        print(self.transaction.location?.address)
        print("pending")
        print(self.transaction.pending)
        print("date: \(transaction.date!)")
        
    }
    
    func dateToString(date: Date) -> String{
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: date)
    }
    

    
    var headerTitle : some View{
        VStack(alignment: .center){
            
            if transaction.categoryMatches != nil{
                TransactionIconViewLarge(icons: viewModel.getIcons(categories: self.transaction.categoryMatches?.allObjects as! [CategoryMatch])).padding(.horizontal).padding(.top, 10).padding(.bottom,10)
            }
            
            
            HStack(){
                Spacer()
                Text(self.transactionService.getDisplayName(transaction: self.transaction)).font(.system(size: 29, design: .rounded)).fontWeight(.bold).multilineTextAlignment(.center).lineLimit(5)
                Spacer()
            }.padding(.horizontal)
                       
                       
                       
                       
            if transaction.pending{
                Text("PENDING").font(.system(size: 18, weight: .medium, design: .rounded)).italic().lineLimit(1).foregroundColor(Color(.lightGray))
            }
            
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
    
    var dateSection : some View{
        VStack{
            HStack{
                Text("Date")
                Spacer()
                Text(dateToString(date: transaction.date ?? Date())).fontWeight(.semibold).bold()

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
    
    var originalNameSection : some View{
        HStack(){
                Text("Full Description")
                Spacer()
                Text(self.transaction.name ?? "Unknown").foregroundColor(Color(.gray)).fontWeight(.semibold).lineLimit(8).multilineTextAlignment(.trailing).padding(.leading, 8)

            
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
    
    func restore(){
        self.viewModel.restoreOriginal()
    }
    
    func split2(){
        self.viewModel.split(num: 2)
    }
    
    func split3(){
        self.viewModel.split(num: 3)
    }
    
    func split4(){
        self.viewModel.split(num: 4)
    }
    
    func split5(){
        self.viewModel.split(num: 5)
    }
    
    
    var actionSection : some View{
        HStack(spacing: 0){
            
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
                }.padding(.horizontal).padding(.vertical, 5).background(Color(.tertiarySystemBackground).opacity(0.65)).cornerRadius(15)

            }
            
            Spacer()
            
            Menu {
                        Button("2 People", action: split2)
                Button("3 People", action: split3)
                        Button("4 People", action: split4)
                        Button("5 People", action: split5)
                        Button("Restore Original", action: restore)
                    } label: {
                        HStack{
                            Spacer()
                            VStack(alignment: .center, spacing: 7){
                                    Image(systemName: "person.fill").imageScale(.large).foregroundColor(AppTheme().themeColorPrimary).padding(.top, 10)
                                Text("Split").foregroundColor(AppTheme().themeColorPrimary).font(.caption).padding(.bottom, 5)
                                }
                            Spacer()
                        }.padding(.horizontal).padding(.vertical, 5).background(Color(.tertiarySystemBackground).opacity(0.65)).cornerRadius(15)
                    }
            
            
            
            
            
                
            
            
        }
        
        
        
    }
    

    
    var categorySection : some View{
        VStack(spacing: 0){
            ForEach(self.transaction.categoryMatches!.allObjects as! [CategoryMatch], id: \.self) { category in
                VStack(spacing: 0){
                    CategoryAmountRowView(viewData: category, viewModel: self.viewModel)
                    
                    
                    
                }
                
            }
        }
    }

    
    var body: some View {
        
        Form{
                
                
            self.headerTitle.listRowBackground(Color.clear).listRowSeparator(.hidden).padding(.bottom, 15)
                
                
                
            //Divider().padding(.horizontal)
                
                actionSection.padding(.top, 20).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear).listRowSeparator(.hidden)
                
            if transaction.categoryMatches != nil{
                if (self.transaction.categoryMatches?.allObjects as! [CategoryMatch]).count > 0{
                
                
                    
                    Section(header: Text("Categories")){
                        self.categorySection
                    }
                
                
            }
            }
            
            
            
            Section(header: Text("GENERAL")){
                self.originalNameSection.padding(.vertical, 8)
                self.dateSection.padding(.vertical, 8)
                self.amountSection.padding(.vertical, 8)
                self.accountSection.padding(.vertical, 8)
                self.settingsSection.padding(.vertical, 8)
                
            }
             
            
            
                
            
                
         
            
            if self.showMap{
                Section(header: Text("Location")){
                    //Map(coordinateRegion: $region, interactionModes: [])
                        //.frame(height: 300, alignment: .center).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).cornerRadius(15).listRowBackground(Color.clear).listRowSeparator(.hidden)
                    
                    Map(coordinateRegion: $region,
                                    annotationItems: annotationItems!) {item in
                                    MapPin(coordinate: item.coordinate)
                                }.frame(height: 300, alignment: .center).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).cornerRadius(15).listRowBackground(Color.clear).listRowSeparator(.hidden)
                    
                }
            }
            
            
            
               
                Button(action: {
                    self.viewModel.deleteTransaction(transaction: self.transaction)
                }) {
                    HStack{
                        Spacer()
                        Image(systemName: "trash").font(.system(size: 21, weight: .regular)).foregroundColor(Color(.red))
                        Text("delete transaction").fontWeight(.semibold).foregroundColor(Color(.red))
                        Spacer()
                    }
                    
                }.buttonStyle(PlainButtonStyle()).padding().background(Color(.red).opacity(0.15)).cornerRadius(20).listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).listRowBackground(Color.clear).listRowSeparator(.hidden)
                
        
        
        
        }
        
    }
}






struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 40.0, longitude: 40.0))
    }
}
