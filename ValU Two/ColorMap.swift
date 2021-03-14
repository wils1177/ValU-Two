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

var colorMap = [Color(#colorLiteral(red: 1, green: 0.6291666667, blue: 0.11, alpha: 1)), Color(#colorLiteral(red: 0.4324, green: 0.92, blue: 0.5136666667, alpha: 1)), Color(#colorLiteral(red: 0.3267, green: 0.868395, blue: 0.99, alpha: 1)), Color(#colorLiteral(red: 0.1, green: 0.4133294802, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1771, green: 0.77, blue: 0.71071, alpha: 1)), Color(#colorLiteral(red: 0.26, green: 0.2262, blue: 0.24479, alpha: 1)),
                Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.gray), Color(.lightGray)
] as [Color]



var colorMapUIKit = [UIColor(#colorLiteral(red: 1, green: 0.6291666667, blue: 0.11, alpha: 1)), UIColor(#colorLiteral(red: 0.4324, green: 0.92, blue: 0.5136666667, alpha: 1)), UIColor(#colorLiteral(red: 0.3267, green: 0.868395, blue: 0.99, alpha: 1)), UIColor(#colorLiteral(red: 0.1, green: 0.4133294802, blue: 1, alpha: 1)), UIColor(#colorLiteral(red: 0.1771, green: 0.77, blue: 0.71071, alpha: 1)), UIColor(#colorLiteral(red: 0.26, green: 0.2262, blue: 0.24479, alpha: 1)),
                     UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)),
                     UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1))
     ]


struct AppTheme {
    
    var themeColorPrimary = Color(.systemBlue)
    
    var themeColorPrimaryUIKit = UIColor(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))

    var themeColorSecondary = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    var otherColor = Color(#colorLiteral(red: 0.8039215803, green: 0.01909826458, blue: 0.3330275909, alpha: 1))
    
    var otherColorSecondary = Color(#colorLiteral(red: 0.9630680514, green: 0.02287900823, blue: 0.3989546255, alpha: 1))
    
    var otherColorTertiary = Color(#colorLiteral(red: 0.7673038082, green: 0.01822835896, blue: 0.3178585387, alpha: 1))
    

}


