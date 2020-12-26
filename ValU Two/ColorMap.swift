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

var colorMap = [Color(#colorLiteral(red: 0.3623140861, green: 0.2386336145, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.3632901721, blue: 0.25, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0.2137254923, blue: 0.4552075302, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.8664457874, blue: 0.2092581555, alpha: 1)), Color(#colorLiteral(red: 0.228705883, green: 0.9529411793, blue: 0.5485349858, alpha: 1)), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.systemFill), Color(.quaternarySystemFill)
]

var colorMapSecondary = [Color(#colorLiteral(red: 0.5, green: 0.4, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.4906321377, blue: 0.4, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0.3419607878, blue: 0.535146418, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.8864410564, blue: 0.3811764717, alpha: 1)), Color(#colorLiteral(red: 0.3811764717, green: 0.9529411793, blue: 0.6336731318, alpha: 1)), Color(.systemPink), Color(.systemGreen), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.systemFill), Color(.quaternarySystemFill)
]

var colorMapTertiaruy = [Color(#colorLiteral(red: 0.1666666667, green: 0, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1510535628, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0.8549019694, green: 0, blue: 0.3219760504, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.8421076411, blue: 0, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.9529411793, blue: 0.4208277668, alpha: 1)), Color(.systemPink), Color(.systemGreen), Color(.systemPink),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.systemFill), Color(.quaternarySystemFill)
]





struct AppTheme {
    
    var themeColorPrimary = Color(#colorLiteral(red: 0, green: 0.9254902005, blue: 0.529608814, alpha: 1))
    
    var themeColorPrimaryUIKit = UIColor(#colorLiteral(red: 0, green: 0.9254902005, blue: 0.529608814, alpha: 1))

    var themeColorSecondary = Color(#colorLiteral(red: 0.6697735156, green: 0.9254902005, blue: 0.8161065725, alpha: 1))
    

}


