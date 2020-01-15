//
//  DashboardPresentor.swift
//  ValU Two
//
//  Created by Clayton Wilson on 1/11/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation

import UIKit
import SwiftUI

struct DashboardViewData{
    var homeViewModel : HomeViewModel?
}

class DashboardViewModel : Presentor{
    
    var coordinator : AppCoordinator?
    var viewData : DashboardViewData?
    
    func configure() -> UIViewController {
        self.viewData = generateViewData()
        let vc = UIHostingController(rootView: DashboardTabView(viewModel: self))
        return vc
    }
    
    func viewAppeared(){
        self.coordinator?.loadDashboard()
    }
    
    func generateViewData() -> DashboardViewData{
        let budget = try? DataManager().getBudget()
        if budget == nil{
            return DashboardViewData(homeViewModel: nil)
        }
        else{
            let homePresentor = HomeViewModel(budget: budget!)
            return DashboardViewData(homeViewModel: homePresentor)
        }
    }
    
    
}
