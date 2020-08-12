//
//  LineGraphView.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/25/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import SwiftUI

struct LineGraphView: View {
    var body: some View {
        VStack{
            HStack{
                Spacer()
                //LineView(data: [34,45,23,45,23,65,68,45])
                LineView2(data: [34,45,23,45,23,65,68,45], title: "Test")
                Spacer()
            }
            
            }.frame( height: 270).background(Color(.white)).cornerRadius(20).shadow(radius: 3)
    }
}

struct LineGraphView_Previews: PreviewProvider {
    static var previews: some View {
        LineGraphView()
    }
}
