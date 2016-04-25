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
    
    

//Mark Refresh Tick
    func timerTick() {
        
        var fader:Float = 0.0
        var isRunning = false
        
        
        if time == 0 {
            time = 1
        }
        
        //  if  UpdateRunningTime() == true {
        isRunning = UpdateRunningTime()
        
        if time != 0 {
            
            fader = (Float(runningTime) / Float(time * REFRESH_PER_10TH) )
            
        }else {
            //Todo:  Special rulles for time at zero  be sure to remove special case above
        }
        
        
        var fixIndex = 0
        for fix in fixStores {
            
            for (name, chan) in fix.channelDic {
                
                if isRunning == true {
                    
                    //All calculations here
                    if chan.icbf == "C" {
                        chan.calLevel = chan.level
                    }
                    else {
                        chan.calLevel = fader * chan.level
                    }
                    
                }
                //ToDo  Call into Fixture and let that routine handle all update (Add a start SubMaster func)
                // print("\(fix.fixtureNumber) name: \(name)  level: \(chan.calLevel)")
                fixtures[fixIndex].channelDic[name]!.checkForHighest(chan.calLevel, excludeFromSave: exclude)
            }
            fixIndex += 1
        }
        //  }
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
    
    
    
    //todo get rid of movie name
    
    func    setMovieImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    

}
