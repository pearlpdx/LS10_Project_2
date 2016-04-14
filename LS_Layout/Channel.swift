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
    
    var parentFixture:Fixture
    
    
    
    
    var name: String?
    var icbf: String?
    
    init (name: String, icbf: String, parentFixture: Fixture){
    
    self.name = name
    self.icbf = icbf
    self.parentFixture = parentFixture
    
    }
    
    
    
    func resetHighestLevels() {
        finalLevel = 0.0
        recLevel = 0.0
        if parentFixture.independent == true {
            finalLevel = indLevel
            recLevel = indLevel
            
        }
    }
    
    func checkForHighest (level: Float, excludeFromSave: Bool) {
        if parentFixture.independent != true {
           
            if level > finalLevel {
                finalLevel = level
            }
            if excludeFromSave == false {
                if level > recLevel {
                    recLevel = level
                }
            }
        }
    }
    
    
    //todo  Remove Timer Tick???
    func timerTick(onInd: Bool) {
        //test only
        if onInd == true {
            finalLevel = indLevel
        }
    }
    
    
    
}
