//
//  GraphBackground.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/4/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct GraphBackground: View {
    
    var graphSpacing = CGFloat(35.0)
    
    var body: some View {
        VStack{

            Divider().padding(.bottom, self.graphSpacing)
            Divider().padding(.bottom, self.graphSpacing)
            Divider().padding(.bottom, self.graphSpacing)
            Divider().padding(.bottom, self.graphSpacing)
            Divider().padding(.bottom, self.graphSpacing)
        }
    }
}

struct GraphBackground_Previews: PreviewProvider {
    static var previews: some View {
        GraphBackground()
    }
}
