//
//  Cue.swift
//  LS10_Project
//
//  Created by Home on 3/15/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import UIKit


class Cue {
    
    init (number: Float, name: String)  {
        
        self.number = Double(number)
        self.name = name
    }

    
   // var picture:UIImage
    
    var number = 0.0
    var name = ""
    var intDownTime = 0.0
    var intUpTime = 0.0
    var intDelayTime = 0.0
    
    var colorTime = 0.0
     
    var waitTime = 0.0
    var linkedCue = 0.0
    
   }
