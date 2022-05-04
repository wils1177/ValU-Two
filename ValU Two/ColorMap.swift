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

var colorMap = [Color(.systemGreen), Color(.systemRed), Color(.systemOrange), Color(.systemTeal), Color(.systemIndigo),
                Color(.systemCyan), Color(.systemMint), Color(.systemPink), Color(.systemPurple), Color(.systemMint), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
                Color(.gray), Color(.lightGray)
] as [Color]



var colorMapUIKit = [UIColor(Color(.systemGreen)), UIColor(Color(.systemRed)), UIColor(Color(.systemOrange)), UIColor(Color(.systemTeal)), UIColor(Color(.systemCyan)),
                     UIColor(Color(.systemMint)), UIColor(Color(.systemPink)), UIColor(Color(.systemPurple)), UIColor(Color(.systemMint)), UIColor(#colorLiteral(red: 0.7202098966, green: 0.7702155709, blue: 0.304389894, alpha: 1)),
                     UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1))
     ]


var theme1 = [Color(#colorLiteral(red: 1, green: 0.6291666667, blue: 0.11, alpha: 1)), Color(#colorLiteral(red: 0.4324, green: 0.92, blue: 0.5136666667, alpha: 1)), Color(#colorLiteral(red: 0.3267, green: 0.868395, blue: 0.99, alpha: 1)), Color(#colorLiteral(red: 0.1, green: 0.4133294802, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1771, green: 0.77, blue: 0.71071, alpha: 1)), Color(#colorLiteral(red: 0.26, green: 0.2262, blue: 0.24479, alpha: 1)),
              Color(.systemBlue), Color(.systemTeal), Color(.systemIndigo), Color(.systemGray4), Color(.systemOrange), Color(.systemPink),
              Color(.gray), Color(.lightGray)
] as [Color]

var theme1UIKit = [UIColor(#colorLiteral(red: 1, green: 0.6291666667, blue: 0.11, alpha: 1)), UIColor(#colorLiteral(red: 0.4324, green: 0.92, blue: 0.5136666667, alpha: 1)), UIColor(#colorLiteral(red: 0.3267, green: 0.868395, blue: 0.99, alpha: 1)), UIColor(#colorLiteral(red: 0.1, green: 0.4133294802, blue: 1, alpha: 1)), UIColor(#colorLiteral(red: 0.1771, green: 0.77, blue: 0.71071, alpha: 1)), UIColor(#colorLiteral(red: 0.26, green: 0.2262, blue: 0.24479, alpha: 1)),
                   UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(Color(.systemIndigo)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)),
                   UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1)), UIColor(#colorLiteral(red: 0.4941176471, green: 0.8784313725, blue: 0.5058823529, alpha: 1))
   ]

    


var theme2 = [Color(#colorLiteral(red: 1, green: 0.6215549111, blue: 0.111124821, alpha: 1)), Color(#colorLiteral(red: 0.8866103292, green: 0.682092905, blue: 0.1947205365, alpha: 1)), Color(#colorLiteral(red: 0.4300732017, green: 0.9208706021, blue: 0.5150589347, alpha: 1)), Color(#colorLiteral(red: 0.3273415565, green: 0.8701939583, blue: 0.991478622, alpha: 1)), Color(#colorLiteral(red: 0.8938070536, green: 0.9993411899, blue: 0.1047025844, alpha: 1)),
                Color(#colorLiteral(red: 0.9468521476, green: 0.9369220138, blue: 0.8895645738, alpha: 1)), Color(#colorLiteral(red: 0.7498543859, green: 0.9750258327, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.7952081561, green: 0.7310792804, blue: 0.2523000538, alpha: 1)), Color(#colorLiteral(red: 0.3438542485, green: 0.8141812086, blue: 0.774463594, alpha: 1)), Color(#colorLiteral(red: 0.7202098966, green: 0.7702155709, blue: 0.304389894, alpha: 1))]


var theme2UIKit = [UIColor(#colorLiteral(red: 1, green: 0.6215549111, blue: 0.111124821, alpha: 1)), UIColor(#colorLiteral(red: 0.8866103292, green: 0.682092905, blue: 0.1947205365, alpha: 1)), UIColor(#colorLiteral(red: 0.4300732017, green: 0.9208706021, blue: 0.5150589347, alpha: 1)), UIColor(#colorLiteral(red: 0.3273415565, green: 0.8701939583, blue: 0.991478622, alpha: 1)), UIColor(#colorLiteral(red: 0.8938070536, green: 0.9993411899, blue: 0.1047025844, alpha: 1)),
                   UIColor(#colorLiteral(red: 0.750785172, green: 0.9548838735, blue: 0.2252872884, alpha: 1)), UIColor(#colorLiteral(red: 0.1772289574, green: 0.7678055167, blue: 0.7148787379, alpha: 1)), UIColor(#colorLiteral(red: 0.7952081561, green: 0.7310792804, blue: 0.2523000538, alpha: 1)), UIColor(#colorLiteral(red: 0.3438542485, green: 0.8141812086, blue: 0.774463594, alpha: 1)), UIColor(#colorLiteral(red: 0.337610662, green: 0.6745378375, blue: 0.4100677371, alpha: 1))]


var globalAppTheme = AppTheme()


struct AppTheme {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var backgroundColor = Color(.systemBackground)
    
   
    
    var backgroundColorUIKit = UIColor(Color(.systemBackground))
    
    var groupBackgroundColor = Color(.tertiarySystemBackground)
    
    var themeColorPrimary = Color(.systemBlue)
    
    var themeColorPrimaryUIKit = UIColor(Color(.systemBlue))

    var themeColorSecondary = Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
    
    var otherColor = Color(#colorLiteral(red: 0.8039215803, green: 0.01909826458, blue: 0.3330275909, alpha: 1))
    
    var otherColorSecondary = Color(#colorLiteral(red: 0.9630680514, green: 0.02287900823, blue: 0.3989546255, alpha: 1))
    
    var otherColorTertiary = Color(#colorLiteral(red: 0.7673038082, green: 0.01822835896, blue: 0.3178585387, alpha: 1))
    
    func getPrimaryTextColor() -> Color{
        return (colorScheme == .dark) ? Color.white : Color.black
    }
    

}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
