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
}



class SubMaster: NSManagedObject {
    
    var fixStores = [FixtureStore]()

    var runningTime:Int32 = 0             //expressed as 10ths * REFRESH_PER_10TH
    
    var runState:runStates = runStates.off


    func timerTick() {
        
        switch runState {
            
        case runStates.off:
            runningTime = 0
            break
            
        case runStates.full:
            runningTime = time * REFRESH_PER_10TH
            break
            
        case runStates.halted:
            //do nothing
            break
            
        case runStates.goingUp:
            runningTime += 1
            if runningTime >= time * REFRESH_PER_10TH {
                runState = runStates.full
            }
            break
            
        case runStates.goingDown:
            runningTime -= 1
            if runningTime <= 0 {
                runState = runStates.off
            }
            break
        }
    }
    
    
    
    func    setMovieImage(img: UIImage) {
        let data = UIImagePNGRepresentation(img)
        self.image = data
    }
    
    func getMovieImg() -> UIImage {
        let img = UIImage(data: self.image!)!
        return img
    }
    

}
