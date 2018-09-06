//
//  networkManager.swift
//  motaDemo
//
//  Created by wang on 2018/9/6.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import PPNetworkHelper
import MBProgressHUD

public let 频道 = "j/app/radio/channels"
class networkManager {
    static let `default` = networkManager()
    
    func request(url:String,parm:[String:Any],success: @escaping (Any?) -> (),failure: @escaping (Error?) -> ()) {
        let url = "https://www.douban.com/".appending(url)
        PPNetworkHelper.post(url, parameters: parm, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
        
    }
}


