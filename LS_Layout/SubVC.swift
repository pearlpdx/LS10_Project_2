//
//  SubVC.swift
//  LS10_Project
//
//  Created by Home on 3/16/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class SubVC: UIViewController,
                UITableViewDataSource,
            UITableViewDelegate  {
    
    
  
    
    @IBOutlet weak var subTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var subs = [Sub]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        subTableView.delegate = self
        subTableView.dataSource = self
        
        //Dummy cues for test  *****************************
        for x in 1...25 {
            let sub = Sub(number: Float(x), name: "This is submaster number: \(x)")
            subs.append(sub)
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("SubTableViewCell", forIndexPath: indexPath) as? SubTableViewCell {
            
            let sub: Sub!
            sub = subs[indexPath.row]
            
            cell.configureCell(sub)
            return cell
        }else {
            return TableFixtureCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subs.count    }
    
    @IBAction func editButtonPressed(sender: AnyObject) {
       subTableView.editing = !subTableView.editing
        if subTableView.editing == true {
            addButton.hidden = false
           editButton.setTitle("DONE", forState: UIControlState.Normal)
        } else {
            addButton.hidden = true
            editButton.setTitle("EDIT", forState: UIControlState.Normal)
        }
    
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
