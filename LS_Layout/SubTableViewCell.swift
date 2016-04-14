//
//  SubTableViewCell.swift
//  LS10_Project
//
//  Created by Home on 3/16/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class SubTableViewCell: UITableViewCell {
    
    var sub: SubMaster!
    
    @IBOutlet weak var subViewCell: UIView!    
    @IBOutlet weak var subNameLbl: UILabel!
    @IBOutlet weak var subDetailLbl: UILabel!
 
    @IBOutlet weak var subSlider: UISlider!
    @IBOutlet weak var subTimeLbl: UILabel!
    @IBOutlet weak var haltButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var subImage: UIImageView!
    @IBOutlet weak var upButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        subViewCell.layer.cornerRadius = 5
       // subImage.layer.borderWidth = 2
        subSlider.setThumbImage(UIImage(named: "sliderTick"), forState: UIControlState.Normal)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(sub: SubMaster) {
        
        self.sub = sub
        //setup notification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(refreshTable(_:)), name: "refresh", object: nil)
        subNameLbl.text = "SM: \(sub.number)  \(sub.name!)"
        subTimeLbl.text = sub.time.fadeString
        if sub.image != nil {
            subImage.image = sub.getMovieImg()
        }

        subSlider.value = 0.0
    }
    
    //called by notification from update timer
    func refreshTable(notification: NSNotification) {
        
        subSlider.value = Float(sub.runningTime) / Float(sub.time * REFRESH_PER_10TH)
        subDetailLbl.text = (sub.runningTime / REFRESH_PER_10TH).shortFadeString
        
        switch sub.runState {
            
        case runStates.goingUp, runStates.goingDown:
            upButton.hidden = true
            downButton.hidden = true
            haltButton.hidden = false
            break
            
        case runStates.off, runStates.goZero:
            upButton.hidden = false
            downButton.hidden = true
            haltButton.hidden = true
            break
            
        case runStates.full, runStates.goFull:
            upButton.hidden = true
            downButton.hidden = false
            haltButton.hidden = true
            break
            
        case runStates.halted:
            upButton.hidden = false
            downButton.hidden = false
            haltButton.hidden = true
            break
            
        }
        
    }

    @IBAction func upButtonPressed(sender: AnyObject) {
        sub.runState = runStates.goingUp
    }
    
    @IBAction func haltButtonPressed(sender: AnyObject) {
        sub.runState = runStates.halted
    }
    
    @IBAction func downButtonPressed(sender: AnyObject) {
        sub.runState = runStates.goingDown
    }
    
    @IBAction func dimButtonPressed(sender: AnyObject) {
        sub.runState = runStates.goZero
    }
    
    @IBAction func brightButtonPressed(sender: AnyObject) {
        sub.runState = runStates.goFull
    }
}
   