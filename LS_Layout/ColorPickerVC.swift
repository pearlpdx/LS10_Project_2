//
//  ColorPickerVC.swift
//  LS_Layout
//
//  Created by Home on 2/4/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import iOS_color_wheel



extension UIColor {
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)  // The resulting Core Image color, or nil
    }
}


extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

     var _curFixture: Channel!

class ColorPickerVC: UIViewController, ISColorWheelDelegate {
    
        @IBOutlet weak var wellView2: UIView!
        @IBOutlet weak var redLbl: UILabel!
        @IBOutlet weak var greenLbl: UILabel!
        @IBOutlet weak var blueLbl: UILabel!
        @IBOutlet weak var amberLbl: UILabel!
        @IBOutlet weak var whiteLbl: UILabel!
        
        @IBOutlet weak var brightnessLbl: UILabel!
        @IBOutlet weak var brightnessSlider: UISlider!
        @IBOutlet weak var redSlider: UISlider!
        @IBOutlet weak var greenSlider: UISlider!
        @IBOutlet weak var blueSlider: UISlider!
        @IBOutlet weak var amberSlider: UISlider!
        @IBOutlet weak var whiteSlider: UISlider!
      //  @IBOutlet weak var wheelView: UIView!
        
        var colorWheel: ISColorWheel!
        var curColor: UIColor?
        var arrayForBool : NSMutableArray = NSMutableArray()
    
       // var curFixture: Channel!
    
    var curFixture: Channel {
        get{
            return _curFixture
        }
        set{
            _curFixture = newValue
        }
        
    }
    
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            if curColor != nil {
                if let myColor = curColor?.coreImageColor {
                    curFixture.indRed = Float(myColor.red)
                    curFixture.indGreen = Float(myColor.green)
                    curFixture.indBlue = Float(myColor.blue)
                }
                
            }
            
            brightnessSlider.value = curFixture.indLevel
            redSlider.value = curFixture.indRed
            greenSlider.value = curFixture.indGreen
            blueSlider.value = curFixture.indBlue
            amberSlider.value = curFixture.indAmber
            whiteSlider.value = curFixture.indWhite
            
            let size: CGSize = self.view.bounds.size
            let wheelSize: CGSize = CGSizeMake(size.width * 0.9, size.width * 0.9)
            self.colorWheel = ISColorWheel(frame: CGRectMake(size.width / 2 - wheelSize.width / 2, size.height * 0.1, wheelSize.width, wheelSize.height))
            self.colorWheel.delegate = self
            self.colorWheel.continuous = true
//            displayRGB(UIColor.whiteColor())
//            brightnessSlider.value = 1.0            //Preset Int Here
//            
            colorWheel.currentColor()
   
            self.view!.addSubview(colorWheel)
            self.wellView2.layer.borderColor = UIColor.blackColor().CGColor
            self.wellView2.layer.borderWidth = 2.0
            self.wellView2.layer.cornerRadius = 15
        }
        
        
        override func viewDidAppear(animated: Bool) {
            
            if curFixture.style == "Intensity" {
                redSlider.hidden = true
                greenSlider.hidden = true
                blueSlider.hidden = true
                amberSlider.hidden = true
                whiteSlider.hidden = true
            }
            
            amberSlider.hidden = true
            whiteSlider.hidden = true
            if curFixture.style?.containsCharactersIn("A") == nil {
                amberSlider.hidden = false
            }
            if curFixture.style?.containsCharactersIn("W") == nil {
                whiteSlider.hidden = false
            }
   
//            if curColor != nil {
//                displayRGB(curColor!)        //Preset Color Here ***************
//            }
            
            updateColorWheel()
        }
        
        
        func colorWheelDidChangeColor(colorWheel: ISColorWheel) {
            
            wellView2.backgroundColor = colorWheel.currentColor()
            displayRGB((colorWheel.currentColor()))           }
        
        
        func displayRGB(color: UIColor) {
            
            if let myCIColor = color.coreImageColor {
                redLbl.text = "\(Int(myCIColor.red * 255))"
                greenLbl.text = "\(Int(myCIColor.green * 255))"
                blueLbl.text = "\(Int(myCIColor.blue * 255))"
                redSlider.value = Float(myCIColor.red)
                greenSlider.value = Float(myCIColor.green)
                blueSlider.value = Float(myCIColor.blue)
                curFixture.indRed = Float(myCIColor.red)
                curFixture.indGreen = Float(myCIColor.green)
                curFixture.indBlue = Float(myCIColor.blue)
            }
        }
        
        
        func updateColorWheel() {
            let color = UIColor(red: CGFloat(redSlider.value),
                green: CGFloat(greenSlider.value),
                blue: CGFloat(blueSlider.value),
                alpha: 1.0)
            colorWheel.setCurrentColor(color)
            wellView2.backgroundColor = colorWheel.currentColor()
            
        }
        
        
        //Actions
        @IBAction func brightnessValueChaged(sender: UISlider) {
            colorWheel.brightness = sender.value
            curFixture.indLevel = sender.value
            wellView2.backgroundColor = colorWheel.currentColor()
            brightnessLbl.text = "\(Int(sender.value * 100))%"
            // displayRGB((colorWheel.currentColor()))
        }
        
        @IBAction func redSliderValueChanged(sender: AnyObject) {
            redLbl.text = "\(Int(redSlider.value * 255))"
//            curFixture.indRed = sender.value
            updateColorWheel()
        }
        
        @IBAction func greenSliderValueChanged(sender: AnyObject) {
            greenLbl.text = "\(Int(greenSlider.value * 255))"
//            curFixture.indGreen = sender.value
            updateColorWheel()
        }
        
        @IBAction func blueSliderValueChanged(sender: AnyObject) {
            blueLbl.text = "\(Int(blueSlider.value * 255))"
//            curFixture.indBlue = sender.value
            updateColorWheel()
        }
        
        @IBAction func amberSliderValueChanged(sender: AnyObject) {
            amberLbl.text = "\(Int(amberSlider.value * 255))"
            curFixture.indAmber = sender.value
        }
        
        @IBAction func whiteSliderValueChanged(sender: AnyObject) {
            whiteLbl.text = "\(Int(whiteSlider.value * 255))"
            curFixture.indWhite = sender.value
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}
