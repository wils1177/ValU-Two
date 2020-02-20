//
//  HistoryViewModel.swift
//  ValU Two
//
//  Created by Clayton Wilson on 2/19/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class HistoryTabViewModel : Presentor {
    
    var budget : Budget
    var coordinator : HistoryTabCoordinator?

    init(budget : Budget){
        self.budget = budget
    }
    
    func configure() -> UIViewController {
        return UIHostingController(rootView: HistoryView())
    }
    
    
    
    func generateViewData(){
        
    }

}
