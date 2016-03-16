//
//  TableFixtureCell.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class TableFixtureCell: UITableViewCell {
    
    var fixture: Channel!
    
    @IBOutlet weak var fixtureCellView: UIView!

    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelSlider: UISlider!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var channelLevel: UILabel!
    
    @IBOutlet weak var butLocked: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        //format slider and imgButton
        channelSlider.setThumbImage(UIImage(named: "thumbNormal"), forState: UIControlState.Normal)
        channelSlider.setThumbImage(UIImage(named: "thumbActive"), forState: UIControlState.Highlighted)
        imgButton.layer.cornerRadius = 10
        imgButton.layer.borderWidth = 2
        fixtureCellView.layer.cornerRadius = 5
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//            }
    
    
    func configureCell(channel: Channel) {
        self.fixture = channel
        channelName.text = channel.name
        butLocked.hidden = !channel.independent
        channelSlider.value = fixture.indLevel
        channelLevel.text = "\(Int(fixture.indLevel * 100))%"
        
        if channel.style == "Intensity" {
            imgButton.hidden = true
        }   else {
            imgButton.hidden = false
            imgButton.backgroundColor = channel.getDislayColor()
        }
       channelNum.text = channel.number
    }
    
    
    @IBAction func imgButtonPressed(sender: AnyObject) {
        //open color dialog
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        self.fixture.independent = true
        butLocked.hidden = false
        self.fixture.indLevel = sender.value
        
        //temp
        channelLevel.text = "\(Int(sender.value * 100))%"
    }
    
    @IBAction func lockButPressed(sender: AnyObject) {
        
        self.fixture.independent = false
        butLocked.hidden = true
    }
}
