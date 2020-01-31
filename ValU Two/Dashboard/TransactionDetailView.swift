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
    
    var viewModel : TransactionDetailViewModel
    
    init(transaction: Transaction){
        self.viewModel = TransactionDetailViewModel(transaction: transaction)
    }
    
    var body: some View {
        VStack{
            if viewModel.viewData?.coordinate != nil{
                MapView(coordinate: (viewModel.viewData?.coordinate!)!)
            }
            
            Text(viewModel.viewData!.name)
        }
        
    }
}

//struct TransactionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionDetailView()
//    }
//}




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
