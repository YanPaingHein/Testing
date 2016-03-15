//
//  CreateAccoutViewController.swift
//  FirebaseLogin
//
//  Created by Nu Wai Thu on 3/11/16.
//  Copyright © 2016 Nu Wai Thu. All rights reserved.
//

import UIKit
import Firebase

class CreateAccoutViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(sender: AnyObject)
    {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, authData) -> Void in
                
                if error == nil
                {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { error, authData in
                        
                        if error == nil
                        {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            print("Account Created :)")
                            self.dismissViewControllerAnimated(true,completion: nil)
                        }
                        else
                        {
                            print(error)
                        }
                    })
                }
                else
                {
                    print(error)
                }
                
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password.", preferredStyle: UIAlertControllerStyle.Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func image(sender: AnyObject) {
        print("AAAAAAAAA")
        let ref = Firebase(url: "https://mobilenu.firebaseio.com/")
       // var base64String : NSString
        let image : UIImage = UIImage(named:"1.png")!
        //Now use image to create into NSData format
        let imageData = UIImagePNGRepresentation(image)
        let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let quoteString = ["string": base64String]
        let userRef = ref.childByAppendingPath("funny")
        let users = ["phototoBase64":quoteString]
        userRef.setValue(users)
        /* let name = ""//nameTextField.text
        var data: NSData = NSData()
        
        
        
        if let image = UIImage(named: "") {
            data = UIImageJPEGRepresentation(image,0.1)!
        }
        
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let user: NSDictionary = ["name":name,"photoBase64":base64String]
        
        //add firebase child node
        let profile = Firebase(url: "\(FIREBASE_REF)").childByAppendingPath("users").childByAppendingPath(name)

        
        // Write data to Firebase
        profile.setValue(user)*/
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
