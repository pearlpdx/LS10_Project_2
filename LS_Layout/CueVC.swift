//
//  CueVC.swift
//  LS10_Project
//
//  Created by Home on 3/15/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import  CoreData


class CueVC: UIViewController,
                UITableViewDataSource,
                UITableViewDelegate  {
    
    
    @IBOutlet weak var cuetableView: UITableView!
    @IBOutlet weak var actionView: UIView!
    
    @IBOutlet weak var playerSlider: UISlider!
    
    var cues = [Cue]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        cuetableView.delegate = self
        cuetableView.dataSource = self
        
        //Dummy cues for test  *****************************
       //for var x = 0; x <= 25; x += 1
        for x in 1...25 {
            let cue = Cue(number: Float(x), name: "This is cue number: \(x)")
            cues.append(cue)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        cuetableView.reloadData()
        actionView.layer.cornerRadius = 5
         playerSlider.setThumbImage(UIImage(named: "sliderTick"), forState: UIControlState.Normal)
        playerSlider.value = 0.0
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        if let cell = tableView.dequeueReusableCellWithIdentifier("CueTableViewCell", forIndexPath: indexPath) as? CueTableViewCell {
            
            let cue: Cue!
            cue = cues[indexPath.row]
            
            cell.configureCell(cue)
            return cell
        }else {
            return TableFixtureCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return cues.count    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
