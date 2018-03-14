//
//  GetInformation.swift
//  MyDemo
//
//  Created by 赵家琛 on 2017/11/13.
//  Copyright © 2017年 赵家琛. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct GetInformation {
    
    static func getNewsInformation(baseURL: String = "http://open.twtstudio.com/api/v1/news", success: @escaping(Dictionary<String, AnyObject>)->(), failure: @escaping (Error)->(), type: Int = 1, page: Int = 1) {
        
        let fullURL = baseURL + "/\(type)/page/\(page)"
        
        Alamofire.request(fullURL).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.result.value {
                    if let dic = data as? Dictionary<String, AnyObject> {
                        success(dic)
                    }
                }
            case .failure(let error):
                print(error)
                failure(error)
                if let data = response.result.value {
                    if let dic = data as? Dictionary<String, AnyObject> {
                        print(dic["message"] as? String ?? "fuck")
                    }
                }
            }
        }
        
    }
    
}
