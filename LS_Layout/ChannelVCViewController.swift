//
//  ChannelVCViewController.swift
//  LS_Layout
//
//  Created by Home on 2/2/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit
import CoreData

class ChannelVCViewController:  UIViewController,
                                UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout,
                                UIPickerViewDataSource,
                                UIPickerViewDelegate{
    
    @IBOutlet weak var chanCollection: UICollectionView!
    
    @IBOutlet weak var pickWheel: UIPickerView!
    var channels = [Channel]()
    
    var steps = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        chanCollection.delegate = self
        chanCollection.dataSource = self
        
        pickWheel.delegate = self
        pickWheel.dataSource = self
        
        for var x = 0; x <= 100; x++ {
            steps.append("\(x)")
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        fetchAndSetResults()
        chanCollection.reloadData()
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

    
    

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ChanCell", forIndexPath: indexPath) as? ChannelCollectionCellVC   {
            
            let chan: Channel!
            
            //            if inSearchMode {
            //                poke = filteredPokemon[indexPath.row]
            //            } else {
            chan = channels[indexPath.row]
            // }
            
            cell.configureCell(chan)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//        //Use a generic seque from ViewController to new View Controller
//        // do not make the seque from the collection Cell
//        
//        let chan: Channel!
//        
//        //        if inSearchMode {
//        //            poke = filteredPokemon[indexPath.row]
//        //        } else {
//        chan = channels[indexPath.row]
//        //}
//        
//        // performSegueWithIdentifier("PokemonDetailVC", sender: poke)
//    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //        if inSearchMode {
        //            return filteredPokemon.count
        //        } else {
        return channels.count
        //}
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(75, 80)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let colorPickerVC = segue.destinationViewController as? ColorPickerVC {
            
            if let channelCollectionCell = sender as? ChannelCollectionCellVC{
                
                colorPickerVC.curChannel = channelCollectionCell.channel
            }
        }
    }
    

    
    
    
    
    //Picket View
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return steps.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return steps[row]
    }
    
 

}
