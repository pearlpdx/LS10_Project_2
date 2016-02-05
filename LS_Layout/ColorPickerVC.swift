//
//  ColorPickerVC.swift
//  LS_Layout
//
//  Created by Home on 2/4/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
//import SwiftColorPicker

extension UIColor {
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)  // The resulting Core Image color, or nil
    }
}


class ColorPickerVC: UIViewController {
//    
//    @IBOutlet var colorWell:ColorWell?
//    @IBOutlet var colorPicker:ColorPicker?
//    @IBOutlet var huePicker:HuePicker?
//    
    
 //   var pickerController: ColorPickerController!
    
 //   var curColor: UIColor!


    override func viewDidLoad() {
        super.viewDidLoad()

//        //         Setup
//        pickerController = ColorPickerController(svPickerView: colorPicker!, huePickerView: huePicker!, colorWell: colorWell!)
//        
//        pickerController.color = UIColor.redColor()
//        
//        // get color updates:
//        pickerController?.onColorChange = {(color, finished) in
//            
//            self.curColor = color
//            
//            
//            
//            if let myCIColor = self.curColor.coreImageColor {
//                
//              //  self.colorLabel.text = "R: \(myCIColor.red) G: \(myCIColor.green) B: \(myCIColor.blue) "
//                
//            }
//            
//         }
//        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
