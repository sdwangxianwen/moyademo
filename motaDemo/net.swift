//
//  net.swift
//  motaDemo
//
//  Created by wang on 2018/9/5.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import Foundation
import Moya
import MBProgressHUD


//MARK:监听网络的状态
let networkPlugin = NetworkActivityPlugin { (type, typ) in
    switch type {
    case .began:
        MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
    case .ended:
        MBProgressHUD.hide(for:  UIApplication.shared.keyWindow!, animated: true)
    }
}

//请求分类
public enum DouBan {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲,参数为歌曲的ID
}

//请求配置
extension DouBan: TargetType {
    
    public var sampleData: Data {
         return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    //请求头
    public var headers: [String : String]? {
        return nil;
    }
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
}

let DouBanProvider = MoyaProvider<DouBan>(plugins:[networkPlugin])

class net: NSObject {

}
