//
//  PlaidLinkWrapper.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/1/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI
import LinkKit


struct PlaidLinkWrapper: UIViewControllerRepresentable{
    
    //typealias UIViewControllerType = PLKPlaidLinkViewController
    
    let navController =  UINavigationController()
    var settingsViewModel : SettingsViewModel
    var presentor = PlaidLinkViewPresentor()
    var loadingAccountsPresentor : LoadingAccountsPresentor
    var linkModal : PLKPlaidLinkViewController
    
    init(viewModel: SettingsViewModel){
        self.settingsViewModel = viewModel
        self.loadingAccountsPresentor = LoadingAccountsPresentor(budget: self.settingsViewModel.budget!)
        
        let vc = presentor.configure() as! PLKPlaidLinkViewController
        self.linkModal = vc
        
    }
    
    func dismissLink(){
        linkModal.dismiss(animated: true)
    }
    
    func makeCoordinator() -> PlaidLinkWrapper.Coordinator {
        return Coordinator(self, presentor: self.loadingAccountsPresentor)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        navController.setNavigationBarHidden(true, animated: false)
        self.presentor.coordinator = context.coordinator
        navController.addChild(self.linkModal)
        return navController
    }
    
    func updateUIViewController(_ pageViewController: UINavigationController, context: Context) {
        print("update is being called for some reason")
    }

    

    
    class Coordinator: NSObject, PlaidLinkDelegate, plaidIsConnectedDelegate {
                
        
        var parent: PlaidLinkWrapper
        var presentor: LoadingAccountsPresentor
        
                
        init(_ parent: PlaidLinkWrapper, presentor: LoadingAccountsPresentor) {
            
            self.parent = parent
            self.presentor = presentor
            super.init()
            presentor.coordinator = self
            
        }
        
        func plaidIsConnected() {
            NotificationCenter.default.post(name: .modelUpdate, object: nil)
            self.parent.navController.dismiss(animated: true)
            self.parent.settingsViewModel.updateView()
        }
        
        func dismissPlaidLink() {
            self.parent.navController.dismiss(animated: true)
        }
        
        func plaidLinkSuccess(sender: PlaidLinkViewPresentor) {
            print("plaid success")
            
            let vc = self.presentor.configure()
            parent.navController.pushViewController(vc, animated: true)
            
            
        }
        
        // MARK: PLKPlaidLinkViewDelegate
        
    }
    
    
    
}
