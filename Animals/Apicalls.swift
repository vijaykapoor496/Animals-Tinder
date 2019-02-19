//
//  Apicalls.swift
//  Animals
//
//  Created by Vijay Kapoor on 18/02/19.
//  Copyright © 2019 Vijay Kapoor. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import UIKit
 let vc = ViewController()
let ep = ExplorePets()
var petlist = [Pets]()
class Apicalls
{
   
    let baseurl = URL(string:"http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/")
    func request(_ username: String,_ password: String,completionHandler:@escaping ((DataResponse<Response>))->Void)
    {
        
        //let namex: String = vc.txtEmail.text!
        //let passx: String = vc.txtPassword.text!
        let url = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/login"
        let param = ["username" : username,"password" :password]
        
        Alamofire.request(url, method: .post, parameters: param as Parameters).responseObject { (response: DataResponse<Response>) in
            completionHandler(response)
                    }
    }
    func apicall(_ token: String,completionHandled:@escaping ((DataResponse<Openblock>))->Void)
    {
        let usertoken =  UserDefaults.standard.string(forKey: "session")
        let headers: HTTPHeaders = [ "Authorization" : token]
        let url = "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets"
        Alamofire.request(url, headers: headers).responseObject() { (responsed: DataResponse<Openblock>) in
            
            completionHandled(responsed)
            
            
        }
        
        
    }
    func updatelikes(direction: String,_ url: String,parameters: Parameters,headers: HTTPHeaders,completionHandled:@escaping ((DataResponse<Openblock>))->Void) {
        let urlString = URL(string: url, relativeTo: baseurl)
        switch direction {
        case "left":
            Alamofire.request(urlString!, method: .put, parameters: parameters,headers: headers).responseObject() { (responsed: DataResponse<Openblock>) in
                
                completionHandled(responsed)
                
                
            }
        case "right":
            Alamofire.request(urlString!, method: .put, parameters: parameters,headers: headers).responseObject() { (responsed: DataResponse<Openblock>) in
                
                completionHandled(responsed)
                
                
            }
        default:
            return
        }
        
    }
    func likedpetinfoRetrival(completionHandled:@escaping ((DataResponse<Openblock>))->Void) {
        
        let url = URL(string: "http://ec2-3-91-83-117.compute-1.amazonaws.com:3000/pets/likes")
        // let headers: HTTPHeaders = ["Authorization": token]
        Alamofire.request(url!, method: .get).responseObject()
            {(response: DataResponse<Openblock>) in
                completionHandled(response)
        }
    }
    
    
}
