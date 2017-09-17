//
//  NetworkRequester.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 8/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation
import Alamofire


enum JsonRequesterResponse {
    case success([String:Any])
    case error(Error)
}

protocol JsonRequester {
    func request(urlString: String, completion:@escaping (JsonRequesterResponse)->())
}


class JsonNetworkRequester : JsonRequester {
    
    var alamofireRequest: Alamofire.Request?
    
    
    func request(urlString: String, completion:@escaping (JsonRequesterResponse)->()) {
        
        alamofireRequest?.cancel()
        
        alamofireRequest = Alamofire.request(urlString).validate().responseJSON { response in
            
            switch response.result {
            case .success(let json):
                if let json = json as? [String:Any] {
                    completion(.success(json))
                }
                else {
                    let error = NSError(domain: "JsonNetworkRequester", code: 1, userInfo: [NSLocalizedDescriptionKey:"unknown"])
                    completion(.error(error))
                }
            case .failure(let error):
                print(error)
                completion(.error(error))
                // TODO: change this so that it ignores ...
                // error Domain=NSURLErrorDomain Code=-999 "cancelled" UserInfo={NSErrorFailingURLStringKey=http://api.geonames.org/searchJSON?u
            }
        }
    }

}
