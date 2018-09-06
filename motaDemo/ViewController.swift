//
//  ViewController.swift
//  motaDemo
//
//  Created by wang on 2018/9/5.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import PPNetworkHelper
import YYModel
import MBProgressHUD

class Subject: HandyJSON {
    var channel_id : String?
    var name       :String?
    var abbr_en    :String?
    var name_en    :String?
    var seq_id     :String?
    required init() {}
}

class channels: HandyJSON {
    //数组list
    var channels: [Subject]! = []
    required init(){}
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //MARK:定义参数
    var tableview :UITableView! //tableview
    var arrM : NSMutableArray!  //存放数据源的可变数组
    var isAfn : Bool!
  
    //MARK:tableview的代理方法和数据源方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrM.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identify:String = "SwiftCell"
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identify, for: indexPath)
        if self.isAfn {
            let channelModel = self.arrM[indexPath.row] as! channelModel
            cell.textLabel?.text = channelModel.name
            cell.backgroundColor = UIColor.brown
        } else {
            let channelModel  = self.arrM[indexPath.row] as! Subject;
            cell.textLabel?.text = channelModel.name
            cell.backgroundColor = hexColor(hex: 0xffbb33)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChannelViewController()
        if self.isAfn {
            let  channelModel = self.arrM[indexPath.row] as! channelModel
            vc.title = channelModel.name
            vc.channleID = channelModel.channel_id
            
        } else {
            let channelModel  = self.arrM[indexPath.row] as! Subject;
            vc.title = channelModel.name
            vc.channleID = channelModel.channel_id
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "AFN请求", style: .done, target: self, action: #selector(afnNetWork))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "MOYA请求", style: .done, target: self, action: #selector(moyaNet))
        self.arrM = NSMutableArray(array: []) //初始化可变数组
        self.isAfn = false
        self.initTableView()
    }
    
    @objc func afnNetWork() {
        //基于afn封装的PPNETWORK,和OC用法一样,字典转模型用的YYMODEL

        let dict : NSDictionary = ["gender" : 1, "since" : 0,"new_device" : false]
        networkManager.default.request(url:频道 , parm: dict , success: { (response) in
            print(response as Any)
            let response = response as! NSDictionary
            let data = response["data"] as! NSDictionary
            let arr = NSArray.yy_modelArray(with: kkModel.self, json: data["comics"] as Any) as! [kkModel]
            let mdel = arr.first
            print(mdel?.topic?.cover_image_url as Any)
            
        }) { (error) in

        }
    }
    @objc func moyaNet()  {
        self.networking()
    }
    
    //MARK:创建tableview
    func initTableView() {
        self.tableview = UITableView(frame: self.view.frame, style: .plain)
        self.view.addSubview(self.tableview)
        self.tableview.delegate = self
        self.tableview.dataSource = self
        //创建一个重用的单元格
        self.tableview!.register(UITableViewCell.self,
                                 forCellReuseIdentifier: "SwiftCell")
    }
     //MARK:网络请求
    func networking() {
        //MOYA请求的数据,字典转模型采用的是阿里的HANDJSON,个人用起来不是很习惯
        DouBanProvider.request(.channels) { (result) in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                let jsonString = json.rawString()!
                print(jsonString)
                if let list = JSONDeserializer<channels>.deserializeFrom(json: json.rawString()) {
                    self.arrM.removeAllObjects()
                    self.isAfn = false
                    self.arrM.addObjects(from: list.channels)
                    self.tableview.reloadData()
                }
            }
        }
    }
}

