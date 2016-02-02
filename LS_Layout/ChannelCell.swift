//
//  ChannelCell.swift
//  LS_2016
//
//  Created by Home on 1/29/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    

    @IBOutlet weak var channelNum: UILabel!
    @IBOutlet weak var channelSlider: UISlider!
    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var imgButton: UIButton!
    @IBOutlet weak var channelLevel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imgButton.layer.cornerRadius = 7.0
        imgButton.clipsToBounds = true
       
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell(channel: Channel) {
        channelName.text = channel.name
        
        
    }
    @IBAction func imgButtonPressed(sender: AnyObject) {
        //open color dialog
    }

    @IBAction func sliderValueChanged(sender: UISlider) {
        channelLevel.text = "\(Int(sender.value * 100))%"
        
    
        
    }
}
