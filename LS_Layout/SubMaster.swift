//
//  SubMaster.swift
//  LS10_Project
//
//  Created by Home on 3/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import CoreData
import UIKit

enum runStates {
    
    case off
    case goingUp
    case goingDown
    case halted
    case full
    case goZero
    case goFull
}



class SubMaster: NSManagedObject {
    
    var fixStores = [FixtureStore]()

    var runningTime:Int32 = 0             //expressed as 10ths * REFRESH_PER_10TH
    
    var runState:runStates = runStates.off
    var fader:Float = 0.0
    

//Mark Refresh Tick
    func timerTick() {
    
        
        if time == 0 {
            time = 1
        }
        
        UpdateRunningTime()
        
        if time != 0 {
            
            fader = (Float(runningTime) / Float(time * REFRESH_PER_10TH) )
            
        }else {
            //Todo:  Special rulles for time at zero  be sure to remove special case above
        }
        
        if runState != runStates.off { 
          
            for fixSt in fixStores {
                
                if let curFix = fixturesDict[Int(fixSt.fixtureNumber) ] {
                    
                    let newInt = fixSt.intensity * fader
                    
                    if newInt > curFix.finalIntensity {
                        curFix.finalIntensity = newInt
                        if exclude == false {
                            curFix.recIntensity = newInt
                        }
                    }
                }
            }
         }
    }
    

    func UpdateRunningTime() -> Bool {
        
        switch runState {
            
        case runStates.off:
            runningTime = 0
            return false
            
        case runStates.full:
            runningTime = time * REFRESH_PER_10TH
            return false
            
        case runStates.halted:
            //do nothing
            return false
            
        case runStates.goingUp:
            runningTime += 1
            if runningTime >= time * REFRESH_PER_10TH {
                runState = runStates.full
            }
            return true
            
        case runStates.goingDown:
            runningTime -= 1
            if runningTime <= 0 {
                runState = runStates.off
            }
            return true
            
        case runStates.goFull:
            runningTime = time * REFRESH_PER_10TH
            runState = runStates.full
            return true
            
        case runStates.goZero:
            runningTime = 0
            runState = runStates.off
            return true
        }
    }
    
    func OnStartPress() {
        
        if fader == 0.0 {
            
            for fixSt in fixStores {
                
                if let curFix = fixturesDict[Int(fixSt.fixtureNumber) ] {
                    
                    if curFix.finalIntensity > 0 {
                        // Fade Color handled in Fixtures LTP
                        curFix.deltaRed = fixSt.red - curFix.finalRed
                        curFix.deltaGreen = fixSt.green - curFix.finalGreen
                        curFix.deltaBlue = fixSt.blue - curFix.finalBlue
                        curFix.originRed = curFix.finalRed
                        curFix.originGreen = curFix.finalGreen
                        curFix.originBlue = curFix.finalBlue
                        curFix.destSubMaster = self
                      
                    }else {
                        //Snap to Color at Start
                        curFix.finalRed = fixSt.red
                        curFix.finalGreen = fixSt.green
                        curFix.finalBlue = fixSt.blue
                        curFix.destSubMaster = nil
                    }
                }
            }
        }
    }
    
    
    
    func    setMyImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    func getMyImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    

}
