//
//  Login.swift
//  JetDevsHomeWork
//
//  Created by Avruti on 09/12/22.
//

import Foundation
import SwiftyJSON

struct LoginDetails {
    
    let email: String
    let password: String
    
    init?(json: JSON) {
        
        guard let email = json["email"].string,let password = json["password"].string
        else {
            return nil
        }
        
        self.email = email
        self.password = password
    }
}
