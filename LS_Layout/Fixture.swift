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
    

    var channels = [Channel]()
    var independent = false
    
    
   // var indRed:Float = 1.0
   // var indGreen:Float = 1.0
   // var indBlue:Float = 1.0
   // var indAmber:Float = 0.0
   // var indWhite:Float = 0.0
    
    var indLevel:Float = 0.0
    
    var finalLevel:Float = 0.0
    
    var finalRecordLevel:Float = 0.0

    var _displayColor: UIColor = UIColor.whiteColor()
    
    
   // ", "RGB", "RGBA", "RGBW", "RGBAW", "I+RGB", "I+RGBA", "I+RGBW", "I+RGBAW"
    
    func setUpChannels() {
        
        print("\(style)")
        
        if style == "Intensity" {
            let chan = Channel(name: "I", icbf: "I")
            channels.append(chan)
            
        }else {
            if style?.rangeOfString("I") != nil {
                var chan = Channel(name: "I", icbf: "I")
                channels.append(chan)
                chan = Channel(name: "R", icbf: "C")
                channels.append(chan)
                chan = Channel(name: "G", icbf: "C")
                channels.append(chan)
                chan = Channel(name: "B", icbf: "C")
                channels.append(chan)
                if style?.rangeOfString("A") != nil {
                    chan = Channel(name: "A", icbf: "C")
                    channels.append(chan)
                }
                if style?.rangeOfString("W") != nil {
                    chan = Channel(name: "W", icbf: "C")
                    channels.append(chan)
                }
                
                
            }else {
                var chan = Channel(name: "R", icbf: "c")
                channels.append(chan)
                chan = Channel(name: "G", icbf: "c")
                channels.append(chan)
                chan = Channel(name: "B", icbf: "c")
                channels.append(chan)
                if style?.rangeOfString("A") != nil {
                    chan = Channel(name: "A", icbf: "c")
                    channels.append(chan)
                }
                if style?.rangeOfString("W") != nil {
                    chan = Channel(name: "W", icbf: "c")
                    channels.append(chan)
                }
                
            }
            
        }
    
    }
    
    
    func getChanByName(name: String) -> Channel? {
        if channels.count != 0 {
            for chan in channels {
                if chan.name == name {
                    return chan
                }
            }
        }
        return nil
    }
    

    
    
    func getDislayColor() -> UIColor {
        
        let indRed = getChanByName("R")?.indLevel
        let indGreen = getChanByName("G")?.indLevel
        let indBlue = getChanByName("B")?.indLevel
        var indAmber = getChanByName("A")?.indLevel
        if indAmber == nil {
            indAmber = 0.0
        }
        var indWhite = getChanByName("W")?.indLevel
        if indWhite == nil {
            indWhite = 0.0
        }
        
        return  UIColor(colorLiteralRed: (indRed! * RGB_MULT) + (indAmber! * AMBER_AND_WHITE) + (indWhite! * AMBER_AND_WHITE),
                        green: (indGreen! * RGB_MULT) + (indAmber! * AMBER_AND_WHITE) + (indWhite! * AMBER_AND_WHITE),
                        blue: (indBlue! * RGB_MULT) + (indWhite! * AMBER_AND_WHITE),
                        alpha: 1.0)
        //print("\((indRed * 0.5) + (indAmber * 0.25) + (indWhite * 0.25)) \((indGreen * 0.5) + (indAmber * 0.25) + (indWhite * 0.25))  \((indBlue * 0.5) + (indWhite * 0.25))")
        
        
    }
    
    func getRGBColor() ->UIColor {
        let indRed = getChanByName("R")?.indLevel
        let indGreen = getChanByName("G")?.indLevel
        let indBlue = getChanByName("B")?.indLevel
        return UIColor(colorLiteralRed: indRed!, green: indGreen!, blue: indBlue!, alpha: 1.0)
    }
    
    func timerTick() {
        
        for chan in channels {
            chan.timerTick(independent)
        }
        
    }



}
