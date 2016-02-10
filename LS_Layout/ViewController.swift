//
//  ViewController.swift
//  LS_Layout
//
//  Created by Home on 2/1/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import  CoreData

var dmx: [UInt8] = []

class ViewController: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate,
                    UISearchBarDelegate   {
    
    @IBOutlet weak var chanTableView: UITableView!
 
    
    var channels = [Channel]()
    
    
    
    let sACN = ACNsend()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        chanTableView.delegate = self
        chanTableView.dataSource = self
        
      
        
        for var x = 0; x < 512; x++ {
            dmx.append(UInt8(0))
        }
        
        sACN.startTimer(dmx, universe: 1)

    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//

    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        chanTableView.reloadData()
    }

    
    
    func fetchAndSetResults() {
        
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Channel")
        
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            self.channels = results as! [Channel]
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    //Table View
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ChannelCell") as? ChannelCell {
            let channel = channels[indexPath.row]
            cell.configureCell(channel)
            return cell
        }else {
            return ChannelCell()
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let colorPickerVC = segue.destinationViewController as? ColorPickerVC {
            
           // if  let channelCell = sender as? ChannelCell {
            
            if let colorButton = sender as? UIButton {
                
                let channelCell = colorButton.superview?.superview as! ChannelCell
          
                colorPickerVC.curChannel = channelCell.channel
            }
        }
    }


    
    @IBAction func unlockButPressed(sender: AnyObject) {
        
        for ch in channels {
            ch.independent = false
        }
        chanTableView.reloadData()
    }

    
    

    
    
}

