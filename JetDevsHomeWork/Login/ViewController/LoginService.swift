//
//  WeatherAPIService.swift
//  WhatsTheWeatherIn
//
//  Created by Marin Benčević on 16/05/16.
//  Copyright © 2016 marinbenc. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct LoginAPIService {
    
    // MARK: - Singleton
    static let shared = LoginAPIService()
    
    // MARK: - URL
    private var loginUrl = "https://jetdevs.mocklab.io/login"
    
    // MARK: - Services
    func requestLogin(withEmail email: String, withPassword password: String, completion: @escaping (User?, String?) -> Void) {
        
        let params: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request(loginUrl, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                    do {
                        let dataModel = try JSONDecoder().decode(DataResult.self, from: data)
                        if(dataModel.result != 0) {
                            completion(dataModel.data.user, nil)
                            return
                        } else {
                            completion(nil, dataModel.errorMessage)
                            return
                        }
                    } catch {
                        print(data)
                        completion(nil, "Request was not matched")
                        return
                    }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                return
            }
        }
    }
    
}
