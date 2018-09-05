//
//  ChannelViewController.swift
//  motaDemo
//
//  Created by wang on 2018/9/5.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import AlamofireImage
import SnapKit


class singersSubject: HandyJSON {
    var  name_usual : String?
    var avatar : String?
    var is_site_artist : Bool?
    var name : String?
    var id :String?
    var related_site_id : NSInteger?
    required init(){}
}
class songSubject: HandyJSON {
    var kbps : String?
    var is_douban_playable : Bool?
    var albumtitle : String?
    var singers : [singersSubject]! = []
    required init(){}
}
class song: HandyJSON {
    var title : String?
    var sid : String?
    var url : String?
    var picture : String?
    var songSubject : [songSubject]! = []
    required init(){}
}
class songModel: HandyJSON {
    var r : String?
    var song : [song]! = []
    required init(){}
}



class ChannelViewController: UIViewController {
    var channleID : String!
    var imageView : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.createUI()
        self.netWork()
    }
    
    func createUI() {
        self.imageView = UIImageView.init()
        self.view.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.left.equalTo(self.view).offset(0)
            make.width.height.equalTo(UIScreen.main.bounds.size.width)
        }
        self.imageView.contentMode = UIViewContentMode.scaleAspectFill
        
        let button = UIButton.init()
        self.view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(30)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.width.height.equalTo(60)
        }
        button.setTitle("▶️", for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
    
    @objc func buttonClick() {
        print("播放")
    }
    
    //MRAK:网络请求
    func netWork() {
        DouBanProvider.request(.playlist(self.channleID)) { (result) in
            if case let .success(response) = result {
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let model = JSONDeserializer<songModel>.deserializeFrom(json: json.rawString()) {
                    print(model.song.first!)
                    let song = model.song[0]
                    print(song.title ?? "22")
                    self.title = song.title ?? "22"
                    self.imageView.af_setImage(withURL: URL(string: song.picture!)!)
                }
            }
        }
    }

}
