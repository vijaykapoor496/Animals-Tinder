//
//  ViewController.swift
//  Animals
//
//  Created by Vijay Kapoor on 09/02/19.
//  Copyright © 2019 Vijay Kapoor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
import AlamofireObjectMapper
import Poi

var apicallsobj = Apicalls()
class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var Stack: UIStackView!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblValidationMessage: UILabel!
    @IBAction func pushedButton(_ sender: UIButton) {
        if ( sender.isSelected == true )
        {
            sender.setBackgroundImage ( UIImage ( named: "unchecked.png"), for: .normal)
            sender.isSelected = false;
        }
            
        else
        {
            sender.setBackgroundImage(UIImage(named: "checked.png" ), for: .selected)
            sender.isSelected = true;
            
        }
    }
    /* func request()
     {
     
     
     let namex: String = txtEmail.text!
     let passx: String = txtPassword.text!
     let url = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/login"
     let param = ["username" : namex,"password" :passx]
     
     Alamofire.request(url, method: .post, parameters: param as Parameters).responseObject { (response: DataResponse<Response>) in
     let obj = response.result.value
     let tok = obj?.response?.data?.token
     if response.response?.statusCode == 200
     { var loginResponse = response.result.value
     print("token storage value: \(loginResponse?.response?.data?.token)")
     UserDefaults.standard.set((loginResponse?.response?.data?.token)!, forKey: "session")
     }
     if obj?.response?.status?.message! == "Sucesss" {
     UserDefaults.standard.set(tok, forKey: "usertoken")
     self.performSegue(withIdentifier: "Secondsegue", sender: self)
     
     }
     else{
     print("User not found")
     }
     }
     } */
    
    
    
    
    
    @IBAction func loginUser()
    {
        lblValidationMessage.isHidden = true
        // swiftlint:disable empty_count
        guard let email = txtEmail.text, txtEmail.text?.characters.count != 0
            else
        {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your email"
            return
        }
        // swiftlint:disable empty_count
        guard let password = txtPassword.text, txtPassword.text?.characters.count != 0
            else
        {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Please enter your password"
            return
            
        }
        apicallsobj.request(txtEmail.text!, txtPassword.text!) { (response) in
            let obj = response.result.value
            let tok = obj?.response?.data?.token
            if response.response?.statusCode == 200
            { var loginResponse = response.result.value
                print("token storage value: \(loginResponse?.response?.data?.token)")
                UserDefaults.standard.set((loginResponse?.response?.data?.token)!, forKey: "session")
            }
            if obj?.response?.status?.message! == "Sucesss" {
                UserDefaults.standard.set(tok, forKey: "usertoken")
                self.performSegue(withIdentifier: "Secondsegue", sender: self)
                
            }
            else{
                print("User not found")
            }
            
            
        }
        
    }
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        if textfield == txtEmail {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else if textfield == txtPassword {
            txtPassword.becomeFirstResponder()
        }
        return true
    }
    
    
    
    
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValidationMessage.isHidden = false
        
        
    }
    
    
}

