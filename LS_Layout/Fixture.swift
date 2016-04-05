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
    
    
    var indRed:Float = 1.0
    var indGreen:Float = 1.0
    var indBlue:Float = 1.0
    var indAmber:Float = 0.0
    var indWhite:Float = 0.0
    
    var indLevel:Float = 0.0
    
    var finalLevel:Float = 0.0 //{
        
//        didSet {
//            
//            NSNotificationCenter.defaultCenter().postNotificationName("refresh", object: nil, userInfo: nil)        
//           
//        }
//    }
    
    var _displayColor: UIColor = UIColor.whiteColor()
    
    func getDislayColor() -> UIColor {
        
        return  UIColor(colorLiteralRed: (indRed * RGB_MULT) + (indAmber * AMBER_AND_WHITE) + (indWhite * AMBER_AND_WHITE),
                        green: (indGreen * RGB_MULT) + (indAmber * AMBER_AND_WHITE) + (indWhite * AMBER_AND_WHITE),
                        blue: (indBlue * RGB_MULT) + (indWhite * AMBER_AND_WHITE),
                        alpha: 1.0)
        //print("\((indRed * 0.5) + (indAmber * 0.25) + (indWhite * 0.25)) \((indGreen * 0.5) + (indAmber * 0.25) + (indWhite * 0.25))  \((indBlue * 0.5) + (indWhite * 0.25))")
        
        
    }
    
    func getRGBColor() ->UIColor {
        return UIColor(colorLiteralRed: indRed, green: indGreen, blue: indBlue, alpha: 1.0)
    }
    
    
    // Insert code here to add functionality to your managed object subclass



}
