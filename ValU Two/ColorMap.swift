//
//  ColorMap.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

var saturation = 0.666
var brightness = 0.99

var colorMap = [Color(#colorLiteral(red: 0.2745098039, green: 0.1333333333, blue: 0.3333333333, alpha: 1)), Color(#colorLiteral(red: 0.1921568627, green: 0.231372549, blue: 0.4470588235, alpha: 1)), Color(#colorLiteral(red: 0.9647058824, green: 0.3176470588, blue: 0.1137254902, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7058823529, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.gray), Color(.lightGray)
] as [Color]

var colorMapSecondary = [Color(#colorLiteral(red: 0.2983135962, green: 0.2142662273, blue: 0.3333333333, alpha: 1)), Color(#colorLiteral(red: 0.286117647, green: 0.3102588235, blue: 0.4470588235, alpha: 1)), Color(#colorLiteral(red: 0.9647058824, green: 0.5539278937, blue: 0.4244705883, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.7058823529, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.3811764717, green: 0.9529411793, blue: 0.6336731318, alpha: 1)), Color(.systemPink), Color(.systemGreen), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.gray), Color(.quaternarySystemFill)
]

var colorMapTertiaruy = [Color(#colorLiteral(red: 0.2352941176, green: 0, blue: 0.3333333333, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.06877828058, blue: 0.4470588235, alpha: 1)), Color(#colorLiteral(red: 0.9647058824, green: 0.7079696395, blue: 0.6270588236, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.8970588235, blue: 0.65, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9529411793, blue: 0.4208277668, alpha: 1)), Color(.systemPink), Color(.systemGreen), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.gray), Color(.quaternarySystemFill)
]





struct AppTheme {
    
    var themeColorPrimary = Color(#colorLiteral(red: 0.568627451, green: 0.1843137255, blue: 0.337254902, alpha: 1))
    
    var themeColorPrimaryUIKit = UIColor(#colorLiteral(red: 0.568627451, green: 0.1843137255, blue: 0.337254902, alpha: 1))

    var themeColorSecondary = Color(#colorLiteral(red: 0.9176470588, green: 0.9490196078, blue: 0.937254902, alpha: 1))
    

}


