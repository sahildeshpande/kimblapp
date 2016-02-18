//
//  LandingViewController.swift
//  Kimbl
//
//  Created by Sahil Deshpande on 04/02/16.
//  Copyright © 2016 KimblApp. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        if isUserLoggedIn {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
