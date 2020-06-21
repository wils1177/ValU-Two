//
//  ColorMap.swift
//  ValU Two
//
//  Created by Clayton Wilson on 4/22/20.
//  Copyright © 2020 Clayton Wilson. All rights reserved.
//

import Foundation
import SwiftUI

var saturation = 0.444
var brightness = 0.99

var colorMap = [Color(hue: 0.234, saturation: saturation, brightness: brightness), Color(hue: 0.345, saturation: saturation, brightness: brightness), Color(hue: 0.666, saturation: saturation, brightness: brightness), Color(hue: 0.555, saturation: saturation, brightness: brightness), Color(hue: 0.444, saturation: saturation, brightness: brightness), Color(hue: 0.333, saturation: saturation, brightness: brightness), Color(hue: 0.222, saturation: saturation, brightness: brightness), Color(hue: 0.675, saturation: saturation, brightness: brightness)]

struct AppTheme {
    
    var themeColorPrimary = Color(.systemBlue)
    
    var themeColorPrimaryUIKit = UIColor.systemBlue

    var themeColorSecondary = Color(.systemRed)
    

}


