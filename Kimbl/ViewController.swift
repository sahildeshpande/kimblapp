//
//  ViewController.swift
//  Kimbl
//
//  Created by Sahil Deshpande on 28/01/16.
//  Copyright © 2016 KimblApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Code to calculate screen width on runtime and based on that choose the appropriate image
        let screenWidth = Int(UIScreen.mainScreen().bounds.size.width)
        let bgImage = UIImage(named: "bg-" + String(screenWidth) + "w")
        let imageview = UIImageView(image: bgImage)
        self.view.addSubview(imageview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")

        if !isUserLoggedIn {
            self.performSegueWithIdentifier("landingView", sender: self)
        }
        
    }

    @IBAction func logoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
        NSUserDefaults.standardUserDefaults().synchronize()
        self.performSegueWithIdentifier("landingView", sender: self)
        
    }

}

