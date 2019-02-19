//
//  Pets.swift
//  Animals
//
//  Created by Vijay Kapoor on 12/02/19.
//  Copyright © 2019 Vijay Kapoor. All rights reserved.
//

import Foundation
import ObjectMapper

class Openblock: Mappable
{
    var eresponse: EResponse?
    required init?(map: Map)
    {
        
    }
    func mapping(map: Map) {
         eresponse <- map["response"]
    }
}
    
    class EResponse: Mappable
    {
        var rdata: Edata?
        var rstatus: Estatus?
       
        required init?(map: Map) {
            
        }
        func mapping(map: Map) {
            rdata <- map["data"]
                rstatus <- map["status"]
        }
    }
   /* class Status: Mappable
    {
        var code: Int??
        var Message: String?
        required init?(map: Map)
        {
            
        }
        func mapping(map: Map) {
            
            code <- map["code"]
            Message <- map["message"]
        }
    } */
    class Edata: Mappable
    {
        var pets: [Pets]?
        required init?(map: Map) {
            
        }
        func mapping(map: Map)
        {
            pets <- map["pets"]
        }
    }
    
    class Pets: Mappable
    {   // swiftlint:disable identifier_name
        var ID: String?
        var Image: String?
        var Name: String?
        var Description: String?
        var Status: Bool?
        
        required public init?(map: Map)
        {
            
        }
        public func mapping(map: Map) {
            ID<-map["_id"]
            Image<-map["image"]
            Name<-map["name"]
            
            Description<-map["description"]
            Status<-map["liked"]
            }
    }
    class Estatus: Mappable
    {
        var code: Int?
        var message: String?
        required init?(map: Map) {
            
        }
        func mapping(map: Map) {
            code<-map["code"]
            message<-map["message"]
            
        }
    }
    

