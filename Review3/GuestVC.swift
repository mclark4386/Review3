//
//  GuestVC.swift
//  Review3
//
//  Created by Matthew Clark on 12/10/19.
//  Copyright © 2019 Matthew Clark. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController {
    var sessionID:String = ""
    
    @IBOutlet weak var sessionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionLabel.text=sessionID
    }
}
