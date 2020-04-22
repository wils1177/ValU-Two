//
//  SectionView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/17/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct SectionView: View {
    
    var view : AnyView
    var title: String
    
    var body: some View {
        VStack(){
            SectionTitleView(title: self.title).padding(.bottom, 10)
            SectionContainerView(view: view)
        }
        
        
    }
}


