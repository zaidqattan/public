//
//  ServersTableViewCell.swift
//  iOSTask
//
//  Created by Zaid Qattan on 11/10/18.
//  Copyright © 2018 Elsuhud. All rights reserved.
//

import UIKit

class ServersTableViewCell: UITableViewCell {
    @IBOutlet var btnMute: UIButton!
    @IBOutlet var btnTimer: UIButton!
    @IBOutlet var btnPhoneCall: UIButton!
    @IBOutlet var btnCheck: UIButton!
    @IBOutlet var lblServerSubnet: UILabel!
    @IBOutlet var lblServerIP: UILabel!
    @IBOutlet var lblCountryName: UILabel!
    @IBOutlet var lblServerName: UILabel!
    @IBOutlet var imgServerLogo: UIImageView!
    @IBOutlet var viewServerStatus: UIView!
    
    var checkMarkIsHighlighted: Bool = false
    var phoneCallIsHighlighted: Bool = false
    var timerIsHighlighted: Bool = false
    var muteIsHighlighted: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkMarkClicked(_ sender: Any) {

        if(!checkMarkIsHighlighted){
            checkMarkIsHighlighted = true
            btnCheck.setImage(UIImage(named: "checkmark-1"), for: .normal)
        }
        else{
            checkMarkIsHighlighted = false
            btnCheck.setImage(UIImage(named: "checkmark-2"), for: .normal)
        }
    }
    @IBAction func phoneCallClicked(_ sender: Any) {
        if(!phoneCallIsHighlighted){
            phoneCallIsHighlighted = true
            btnPhoneCall.setImage(UIImage(named: "call-1"), for: .normal)
        }
        else{
            phoneCallIsHighlighted = false
            btnPhoneCall.setImage(UIImage(named: "call-2"), for: .normal)
        }
    }
    
    @IBAction func timerClicked(_ sender: Any) {
        if(!timerIsHighlighted){
            timerIsHighlighted = true
            btnTimer.setImage(UIImage(named: "stopwatch-1"), for: .normal)
        }
        else{
            timerIsHighlighted = false
            btnTimer.setImage(UIImage(named: "stopwatch-2"), for: .normal)
        }
    }
    @IBAction func muteClicked(_ sender: Any) {
        if(!muteIsHighlighted){
            muteIsHighlighted = true
            btnMute.setImage(UIImage(named: "mute-1"), for: .normal)
        }
        else{
            muteIsHighlighted = false
            btnMute.setImage(UIImage(named: "mute-2"), for: .normal)
        }
    }
}
