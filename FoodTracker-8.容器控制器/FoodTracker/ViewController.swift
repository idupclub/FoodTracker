//
//  ViewController.swift
//  FoodTracker
//
//  Created by Chun Cao on 16/7/10.
//  Copyright © 2016年 idup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var helloLabel: UILabel!

    @IBOutlet weak var nameText: UITextField!
    
    @IBAction func okPressed(sender: AnyObject) {
        self.helloLabel.text = "Hello " + self.nameText.text!
    }

}

