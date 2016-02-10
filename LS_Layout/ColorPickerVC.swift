//
//  ColorPickerVC.swift
//  LS_Layout
//
//  Created by Home on 2/4/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

class ColorPickerVC: UIViewController, UITextFieldDelegate {
    
    
    var curChannel:Channel?
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var amberSlider: UISlider!
    @IBOutlet weak var whiteSlider: UISlider!
    
    @IBOutlet weak var redText: MaterialTextField!
    @IBOutlet weak var greenText: MaterialTextField!
    @IBOutlet weak var blueText: MaterialTextField!
    @IBOutlet weak var amberText: MaterialTextField!
    @IBOutlet weak var whiteText: MaterialTextField!
    
    @IBOutlet weak var colorPreview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFields()
  
    }
    
    func initTextFields() {
        redText.delegate = self
        redText.keyboardType = UIKeyboardType.NumberPad
        redSlider.value = (curChannel?.indRed)!
        
        greenText.delegate = self
        greenText.keyboardType = UIKeyboardType.NumberPad
        greenSlider.value = (curChannel?.indGreen)!
        
        blueText.delegate = self
        blueText.keyboardType = UIKeyboardType.NumberPad
        blueSlider.value = (curChannel?.indBlue)!
        
        amberText.delegate = self
        amberText.keyboardType = UIKeyboardType.NumberPad
        amberSlider.value = (curChannel?.indAmber)!
        
        whiteText.delegate = self
        whiteText.keyboardType = UIKeyboardType.NumberPad
        whiteSlider.value = (curChannel?.indWhite)!
        
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    
    
    //Delegates
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String)
        -> Bool
    {
        // We ignore any change that doesn't add characters to the text field.
        // These changes are things like character deletions and cuts, as well
        // as moving the insertion point.
        //
        // We still return true to allow the change to take place.
        if string.characters.count == 0 {
            return true
        }
        
        // Check to see if the text field's contents still fit the constraints
        // with the new content added to it.
        // If the contents still fit the constraints, allow the change
        // by returning true; otherwise disallow the change by returning false.
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)
        
        let decimalSeparator = NSLocale.currentLocale().objectForKey(NSLocaleDecimalSeparator) as! String
        return prospectiveText.isNumeric() &&
            prospectiveText.doesNotContainCharactersIn("-e" + decimalSeparator) &&
            prospectiveText.characters.count <= 3
        
        // Do not put constraints on any other text field in this view
        // that uses this class as its delegate.
        
    }
    
    
    
    
    // Dismiss the keyboard when the user taps the "Return" key or its equivalent
    // while editing a text field.
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
 
    @IBAction func userTapBackground(sender: AnyObject) {
         view.endEditing(true)
    }
    
    
    
    func sliderValueChanged(slider: UISlider, textbox: UITextField) {
        textbox.text = "\(Int(slider.value * 255))"
        view.endEditing(true)
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    func textEnds(textbox: UITextField, slider: UISlider) {
        
        if textbox.text != "" {
            var dd:Float = (textbox.text?.floatValue)!
            if dd > 255 {
                dd = 255
                
            }
            slider.value = dd / 255.0
            textbox.text = "\(Int(dd))"
        }
    }

    
    //Sliders
    @IBAction func redVauleChanged(sender: AnyObject) {
        curChannel?.indRed = redSlider.value
        sliderValueChanged(redSlider, textbox: redText)
    }
    
    @IBAction func greenValueChanged(sender: AnyObject) {
        curChannel?.indGreen = greenSlider.value
        sliderValueChanged(greenSlider, textbox: greenText)
    }
    
    @IBAction func blueValueChanged(sender: AnyObject) {
        curChannel?.indBlue = blueSlider.value
        sliderValueChanged(blueSlider, textbox: blueText)
    }
    
    @IBAction func amberValueChanged(sender: AnyObject) {
        curChannel?.indAmber = amberSlider.value
        sliderValueChanged(amberSlider, textbox: amberText!)
    }
    
    @IBAction func whiteValueChanged(sender: AnyObject) {
        curChannel?.indWhite = whiteSlider.value
        sliderValueChanged(whiteSlider, textbox: whiteText)
    }
    
    //Test Boxes
    
    @IBAction func redTextEnd(sender: AnyObject) {
        textEnds(redText, slider: redSlider)
        curChannel?.indRed = redSlider.value
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    @IBAction func greenTextEnd(sender: AnyObject) {
        textEnds(greenText, slider: greenSlider)
        curChannel?.indGreen = greenSlider.value
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    @IBAction func blueTextEnd(sender: AnyObject) {
        textEnds(blueText, slider: blueSlider)
        curChannel?.indBlue = blueSlider.value
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    @IBAction func amberTextEnd(sender: AnyObject) {
        textEnds(amberText, slider: amberSlider)
        curChannel?.indAmber = amberSlider.value
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    @IBAction func whiteTextEnds(sender: AnyObject) {
        textEnds(whiteText, slider: whiteSlider)
        curChannel?.indWhite = whiteSlider.value
        colorPreview.backgroundColor = curChannel?.getDislayColor()
    }
    
    @IBAction func updatePressed(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    
    
}
