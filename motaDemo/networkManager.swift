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
//单例管理AFN的网络请求,闭包的,使用尾随闭包需要使用@escaping修饰,闭包默认是非逃逸的,修饰之后,变成逃逸的,通俗点说就是这个闭包在函数执行完成之后才被调用,但是逃逸闭包要考虑闭包内的self的持有,此时与block类似,非逃逸闭包是不用考虑self的持有,是较为安全的
class networkManager {
    static let `default` = networkManager() //swift的单例,就这么一句话
    
    /// 网络请求
    ///
    /// - Parameters:
    ///   - url: 请求的地址
    ///   - parm: 请求的参数
    ///   - success: 成功的回调
    ///   - failure: 失败的回调
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


