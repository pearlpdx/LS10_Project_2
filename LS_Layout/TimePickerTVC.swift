//
//  TimePickerTVC.swift
//  LS10_Project
//
//  Created by Home on 3/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class TimePickerTVC: UITableViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var sec = [String]()
    var min = [String]()
    var tenth = [String]()
    
    var curTime:Int32 = 50
    
      
    @IBOutlet weak var timePickerView: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        //build picker
        for x in 0...59 {
            sec.append("\(x) sec")
        }
        
        min.append(" ")
        for m in 1...59 {
            min.append("\(m) min")
        }
    
        for t in 0...9 {
            tenth.append(".\(t)")
        }
        
        setPickerView(Int(curTime))
        
    }
    
    
    func setPickerView(tenth: Int) {
        timePickerView.selectRow(tenth / 600, inComponent: 0, animated: true)
        timePickerView.selectRow((tenth % 600) / 10, inComponent: 1, animated: true)
        timePickerView.selectRow((tenth % 60) % 10, inComponent: 2, animated: true)
    }
    
 
    
    //MARK PickerView
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return min.count
        }else if component == 1 {
            return sec.count
        }
        return tenth.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return min[row]
        } else if component == 1 {
            return sec[row]
        }
        return tenth[row]
    }
    //todo:  
 
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    
    
    func pickerValueInt() -> Int32 {
        var val = timePickerView.selectedRowInComponent(0) * 600
        val += timePickerView.selectedRowInComponent(1) * 10
        val += timePickerView.selectedRowInComponent(2)
        return Int32(val & 0xFFFF)
    }

    @IBAction func backButtonPress(sender: AnyObject) {
        _curTime = pickerValueInt()   //This is cheating but it works
        
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//       if  let navVC = segue.destinationViewController as? UINavigationController {
//            
//         if let destVC = navVC.viewControllers.first as? SubSetupTVC {
//                  destVC.curTime = pickerValueInt()
//            }
//            
//        }
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
    

}
