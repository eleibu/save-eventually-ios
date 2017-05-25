//
//  ViewController.swift
//  SaveEventually
//
//  Created by Elliot Leibu on 25/5/17.
//  Copyright © 2017 elliotleibu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sendDataTask = SendDataWhenReachable(data: "Hello")
        (UIApplication.shared.delegate as! AppDelegate).scheduleTask(sendDataTask)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
