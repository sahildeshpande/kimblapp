//
//  LoginViewController.swift
//  Kimbl
//
//  Created by Sahil Deshpande on 09/02/16.
//  Copyright © 2016 KimblApp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
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
    

    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        
        // Creating the URL, request object and making a async HTTP connection
        let url:NSURL = NSURL(string: "http://kimblapp.com/fetchuserdata.php")!
        let postString = "email=\(userEmail)&password=\(userPassword)"
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        // Code for showing spinner
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        
        let dataTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData?, urlResponse: NSURLResponse?, error: NSError?) -> Void in
            
            // Code to stop the spinner
            indicator.stopAnimating()
            dispatch_async(dispatch_get_main_queue(), {
                indicator.removeFromSuperview()
            })
            
            // Code to check if response received properly
            if let response = urlResponse as? NSHTTPURLResponse {
                
                NSLog("Response code: %ld", response.statusCode)
                
                if response.statusCode >= 200 && response.statusCode < 300 {
                    
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                        
                        if json != nil {
                            
                            if let parseJSON = json {
                                let userIDReturned:Int = parseJSON["userid"] as! Int
                                let userNameReturned:String = parseJSON["name"] as! String
                                let userEmailReturned:String = parseJSON["email"] as! String
                                let userPasswordReturned:String = parseJSON["password"] as! String
                                //var userNewPhoneReturned:String = parseJSON["newphone"] as! String
                                
                                if userEmailReturned == userEmail {
                                    if userPasswordReturned == userPassword {
                                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                                        NSUserDefaults.standardUserDefaults().setInteger(userIDReturned,forKey: "userID")
                                        NSUserDefaults.standardUserDefaults().setObject(userNameReturned, forKey: "userName")
                                        NSUserDefaults.standardUserDefaults().setObject(userEmailReturned, forKey: "userEmail")
                                        NSUserDefaults.standardUserDefaults().synchronize()
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                }
                            }
                            
                        }else {
                            let myAlert = UIAlertController(title: "Sorry", message: "Login details incorrect!", preferredStyle: UIAlertControllerStyle.Alert)
                            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                            myAlert.addAction(okAction)
                            NSOperationQueue.mainQueue().addOperationWithBlock {
                                self.presentViewController(myAlert, animated:true , completion: nil)
                            }
                        }
                        
                    }catch let error as NSError {
                        error
                        return
                    }
                }else {
                    let myAlert = UIAlertController(title: "Oops", message: "There was a problem. Try again.", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(okAction)
                    NSOperationQueue.mainQueue().addOperationWithBlock {
                        self.presentViewController(myAlert, animated:true , completion: nil)
                    }
                }
            }
        })
        dataTask.resume()
        
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
