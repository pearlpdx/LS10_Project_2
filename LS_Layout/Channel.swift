//
//  Channel.swift
//  LS10_Project
//
//  Created by Home on 4/12/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation

class Channel {
    
    var distLevel: Float = 0.0
    var indLevel: Float = 0.0
    var finalLevel: Float = 0.0
    var recLevel: Float = 0.0
    
    var name: String?
    var icbf: String?
    
    init (name: String, icbf: String) {
    
    self.name = name
    self.icbf = icbf
    }
    
    
    func timerTick(onInd: Bool) {
        //test only
        if onInd == true {
            finalLevel = indLevel
        }
    }
    
    
    
}
