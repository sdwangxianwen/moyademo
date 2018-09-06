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

class networkManager {
    static let `default` = networkManager()
    
    func request(url:String,parm:[String:Any],success: @escaping (Any?) -> (),failure: @escaping (Error?) -> ()) {
        let url = HOSTAPI.appending(url)
        MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        PPNetworkHelper.post(url, parameters: parm, success: { (response) in
            success(response)
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        }) { (error) in
            failure(error)
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        }
    }
}


