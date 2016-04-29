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

       var curFixture: Fixture?

class ColorPickerVC: UIViewController, ISColorWheelDelegate {
    
        @IBOutlet weak var wellView2: UIView!
        @IBOutlet weak var redLbl: UILabel!
        @IBOutlet weak var greenLbl: UILabel!
        @IBOutlet weak var blueLbl: UILabel!
    
        @IBOutlet weak var brightnessLbl: UILabel!
        @IBOutlet weak var brightnessSlider: UISlider!
        @IBOutlet weak var redSlider: UISlider!
        @IBOutlet weak var greenSlider: UISlider!
        @IBOutlet weak var blueSlider: UISlider!
        
        var colorWheel: ISColorWheel!
        var curColor: UIColor?
        var arrayForBool : NSMutableArray = NSMutableArray()
    
//       var curFixture: Fixture?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if curColor != nil {
                if let myColor = curColor?.coreImageColor {
                    
                    curFixture?.finalRed = Float(myColor.red)
                    curFixture?.finalGreen = Float(myColor.green)
                    curFixture?.finalBlue = Float(myColor.blue)
                }
            }
            
            brightnessSlider.value = (curFixture?.finalIntensity)!
            redSlider.value = (curFixture?.finalRed)!
            greenSlider.value = (curFixture?.finalGreen)!
            blueSlider.value = (curFixture?.finalBlue)!
            
            brightnessLbl.text = "\(Int((curFixture?.finalIntensity)! * 100))%"
            redLbl.text = "\(Int((curFixture?.finalRed)! * 255))"
            greenLbl.text = "\(Int((curFixture?.finalGreen)! * 255))"
            blueLbl.text = "\(Int((curFixture?.finalBlue)! * 255))"
        
        
        let size: CGSize = self.view.bounds.size
        let wheelSize: CGSize = CGSizeMake(size.width * 0.9, size.width * 0.9)
        self.colorWheel = ISColorWheel(frame: CGRectMake(size.width / 2 - wheelSize.width / 2, size.height * 0.1, wheelSize.width, wheelSize.height))
        self.colorWheel.delegate = self
        self.colorWheel.continuous = true
        colorWheel.currentColor()
        
        self.view!.addSubview(colorWheel)
        self.wellView2.layer.borderColor = UIColor.blackColor().CGColor
        self.wellView2.layer.borderWidth = 2.0
        self.wellView2.layer.cornerRadius = 15
    }
    
    
        override func viewDidAppear(animated: Bool) {
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

                curFixture?.finalRed = Float(myCIColor.red)
                curFixture?.finalGreen = Float(myCIColor.green)
                curFixture?.finalBlue = Float(myCIColor.blue)
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
            wellView2.backgroundColor = colorWheel.currentColor()
            brightnessLbl.text = "\(Int(sender.value * 100))%"
            curFixture?.indIntensity = sender.value
        }
        
        @IBAction func redSliderValueChanged(sender: AnyObject) {
            redLbl.text = "\(Int(redSlider.value * 255))"
            curFixture?.finalRed = sender.value
            updateColorWheel()
        }
        
        @IBAction func greenSliderValueChanged(sender: AnyObject) {
            greenLbl.text = "\(Int(greenSlider.value * 255))"
            curFixture?.finalGreen = sender.value
            updateColorWheel()
        }
        
        @IBAction func blueSliderValueChanged(sender: AnyObject) {
            blueLbl.text = "\(Int(blueSlider.value * 255))"
            curFixture?.finalBlue = sender.value
            updateColorWheel()
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
}
