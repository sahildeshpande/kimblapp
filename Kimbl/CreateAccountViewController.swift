//
//  CreateAccountViewController.swift
//  Kimbl
//
//  Created by Sahil Deshpande on 09/02/16.
//  Copyright © 2016 KimblApp. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let screenWidth = Int(UIScreen.mainScreen().bounds.size.width)
        let bgImage = UIImage(named: "bg-" + String(screenWidth) + "w")
        let imageview = UIImageView(image: bgImage)
        self.view.addSubview(imageview)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let userName = userNameTextField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        
        
        // Check for empty fields
        if(userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty){
            // Display alert message
            displayAlertMessage("All fields are required!")
            return
        }
        
        
        // Creating the URL, request object and making a async HTTP connection
        let url:NSURL = NSURL(string: "http://kimblapp.com/register.php")!
        let postString = "name=\(userName)&email=\(userEmail)&password=\(userPassword)&newphone=\("false")"
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Code for showing spinner
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        let dataTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> Void in
            indicator.stopAnimating()
            if let response = urlResponse as? NSHTTPURLResponse
                
            {
                NSLog("Response code: %ld", response.statusCode)
                
                if (response.statusCode >= 200 && response.statusCode < 300) {
                    // Display confirmation alert message
                    let myAlert = UIAlertController(title: "Congrats", message: "Registered successfully!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
                        action in self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    myAlert.addAction(okAction)
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.presentViewController(myAlert, animated:true , completion: nil)
                    }
                    
                } else {
                    let myAlert = UIAlertController(title: "Oops", message: "There was a problem. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    
                    myAlert.addAction(okAction)
                }

            }
        })
        dataTask.resume()
    
        
    }
    
    func displayAlertMessage(userDefinedMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userDefinedMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated:true , completion: nil)
        
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
