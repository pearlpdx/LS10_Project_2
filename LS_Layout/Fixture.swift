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
    
    
    var independent = false
    

    var _displayColor: UIColor = UIColor.whiteColor()
    
    var finalIntensity:Float = 0.0
    var indIntensity:Float = 0.0
    var recIntensity:Float = 0.0
    
    
    
    var finalRed:Float = 1.0
    var finalGreen:Float = 1.0
    var finalBlue:Float = 1.0
    
    var indRed:Float = 1.0
    var indGreen:Float = 1.0
    var indBlue:Float = 1.0
    
    var deltaRed:Float = 1.0
    var deltaGreen:Float = 1.0
    var deltaBlue:Float = 1.0
    
    var originRed:Float = 1.0
    var originGreen:Float = 1.0
    var originBlue:Float = 1.0
    
    var destSubMaster:SubMaster?
    
    

    func getRGBColor() ->UIColor {
        return UIColor(colorLiteralRed: finalRed * finalIntensity, green: finalGreen * finalIntensity, blue: finalBlue * finalIntensity, alpha: 1.0)
    }
    
    func timerTick () {
        
        var dmxOffset = 0

        for (_, fix) in fixturesDict {
            
            dmxOffset = Int(fix.dmxStart)
            
            if fix.style == "Intensity" {
                //no color
                if fix.independent == true {
                    // On Ind
                    fix.finalIntensity = fix.indIntensity
                    fix.recIntensity = fix.indIntensity
                }
                dmx[dmxOffset] = UInt8(255 * fix.finalIntensity)
                
            }else {
                //All Color Fixtures
                if fix.independent   == true {
                    //color on Ind
                    fix.finalIntensity = fix.indIntensity
                    fix.recIntensity = fix.indIntensity
                    
                }else {
                    //color fixture type -- not on Ind
                    if let sub = fix.destSubMaster {
                        
                        //Color is fading -- do Last Action Fade
                        fix.finalRed = (fix.deltaRed * sub.fader) + fix.originRed
                        fix.finalGreen = (fix.deltaGreen  * sub.fader) + fix.originGreen
                        fix.finalBlue = (fix.deltaBlue  * sub.fader) + fix.originBlue
                        
                        if sub.fader == 1 {
                            //SubMaster at full -- Stop Last Action Fades
                            fix.destSubMaster = nil
                        }
                    }  
                    
                }
                if fix.style?.rangeOfString("I") == nil {
                    //Phantom Intensity
                    let red = fix.finalRed * fix.finalIntensity
                    dmx[dmxOffset] = UInt8(255 * red)
                    dmxOffset += 1
                    
                    let green = fix.finalGreen * fix.finalIntensity
                    dmx[dmxOffset] = UInt8(255 * green)
                    dmxOffset += 1
                    
                    let blue = fix.finalBlue * fix.finalIntensity
                    dmx[dmxOffset] = UInt8(255 * blue)
                    dmxOffset += 1
                    
                    if fix.style?.rangeOfString("A") != nil {
                        let amber = min(fix.finalRed, fix.finalGreen) * fix.finalIntensity
                        dmx[dmxOffset] = UInt8(255 * amber)
                        dmxOffset += 1
                    }
                    
                    if fix.style?.rangeOfString("W") != nil {
                        let white = min(fix.finalRed, fix.finalGreen, fix.finalBlue) * fix.finalIntensity
                        dmx[dmxOffset] = UInt8(255 * white)
                    }
                    
                    
                }else {
                    // Intensity Channel
                    dmx[dmxOffset] = UInt8(255 * fix.finalIntensity)
                    dmxOffset += 1
                    //   print("Start: \(fix.dmxStart)  Level: \(UInt8(255 * fix.finalIntensity))")
                    dmx[dmxOffset] = UInt8(255 * fix.finalRed)
                    dmxOffset += 1
                    dmx[dmxOffset] = UInt8(255 * fix.finalGreen)
                    dmxOffset += 1
                    dmx[dmxOffset] = UInt8(255 * fix.finalBlue)
                    dmxOffset += 1
                    
                    
                    if fix.style?.rangeOfString("A") != nil {
                        let amber = min(fix.finalRed, fix.finalGreen)
                        dmx[dmxOffset] = UInt8(255 * amber)
                        dmxOffset += 1
                    }
                    
                    if fix.style?.rangeOfString("W") != nil {
                        let white = min(fix.finalRed, fix.finalGreen, fix.finalBlue)
                        dmx[dmxOffset] = UInt8(255 * white)
                    }
                }
            }
            
        }
    }
    
    
    
    
}
