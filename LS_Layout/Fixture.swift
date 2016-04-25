//
//  Fixture.swift
//  LS10_Project
//
//  Created by Gordon Pearlman on 4/4/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Fixture: NSManagedObject {
    
   // var channels = [Channel]()              //for coredata onlly
    var channelDic = [String: Channel] ()
    
    var independent = false
    

    var _displayColor: UIColor = UIColor.whiteColor()
    
    
   // ", "RGB", "RGBA", "RGBW", "RGBAW", "I+RGB", "I+RGBA", "I+RGBW", "I+RGBAW"
    
    func setUpChannels() {
        
        if style == "Intensity" {
            let chan = Channel(name: "I", icbf: "I", parentFixture: self)
            channelDic["I"] = chan
            
        }else {
            if style?.rangeOfString("I") != nil {
                let chan = Channel(name: "I", icbf: "I", parentFixture: self)
                channelDic["I"] = chan
            }
            
            var chan = Channel(name: "R", icbf: "C", parentFixture: self)
            channelDic["R"] = chan
            
            chan = Channel(name: "G", icbf: "C", parentFixture: self)
            channelDic["G"] = chan
            
            chan = Channel(name: "B", icbf: "C", parentFixture: self)
            channelDic["B"] = chan
            
        }
        
    }
    
    
    //???  should this indLevel or finalLev
    func getRGBColor() ->UIColor {
        let indRed = channelDic["R"]?.finalLevel
        let indGreen = channelDic["G"]?.finalLevel
        let indBlue = channelDic["B"]?.finalLevel
        return UIColor(colorLiteralRed: indRed!, green: indGreen!, blue: indBlue!, alpha: 1.0)
    }
    
    
}
