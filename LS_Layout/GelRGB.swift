//
//  GelRGB.swift
//  colorPickerTest
//
//  Created by Gordon Pearlman on 2/27/16.
//  Copyright © 2016 Gordon Pearlman. All rights reserved.
//

import Foundation


class GelRGB {
    
    
//    var index: String!
//    var mfg: String!
    var number: String!
    var name: String!
    var red: Float!
    var green: Float!
    var blue: Float!
    
    
    init (number: String, name: String, red: Float, green: Float, blue: Float) {
        
        self.number = number
        self.name = name
        self.red = red
        self.green = green
        self.blue = blue
    }
    

}


class GelSection {
    
    var mfg: String!
    var gelRGBs: [GelRGB]!
    
    init (mfg: String, gels: [GelRGB] ) {
        
        self.mfg = mfg
        self.gelRGBs = gels
    }
    
}

