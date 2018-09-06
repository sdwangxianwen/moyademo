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
            cell.backgroundColor = UIColor.white
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let channelModel  = self.arrM[indexPath.row] as! Subject;
         let vc = ChannelViewController()
        vc.title = channelModel.name
        vc.channleID = channelModel.channel_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "AFN请求", style: .done, target: self, action: #selector(afnNetWork))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "MOYA请求", style: .done, target: self, action: #selector(moyaNet))
        
        self.arrM = NSMutableArray(array: []) //初始化可变数组
        self.isAfn = false
        self.initTableView()
//        self.networking()
    }
    
    @objc func afnNetWork() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        PPNetworkHelper.post("https://www.douban.com/j/app/radio/channels", parameters: nil, success: { (response) in
           let response = response as! NSDictionary
            let arr = NSArray.yy_modelArray(with: channelModel.self, json: response["channels"] as! [channelModel])
            print(arr as Any)
            self.arrM.removeAllObjects()
            self.isAfn = true
            self.arrM.addObjects(from: arr!)
            self.tableview.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
            
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

