//
//  Extensions.swift
//  colorPickerTest
//
//  Created by Gordon Pearlman on 3/3/16.
//  Copyright © 2016 Gordon Pearlman. All rights reserved.
//

import Foundation

extension Double {
    
    var dmx: UInt8 { return UInt8( Double(255) * self) }
    
    var dmxHigh: UInt8 { return (UInt8  (UInt16( 65535.0 * self) >> 8)) }
    
    var dmxLow: UInt8 { return (UInt8  (UInt16( 65535.0 * self) & 0xFF)) }
    
}

