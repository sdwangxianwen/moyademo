//
//  kkModel.swift
//  motaDemo
//
//  Created by wang on 2018/9/6.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

@objcMembers class user: NSObject {
    var avatar_url :String?
    var grade :String?
    var  id :String?
    var nickname :String?
    var pub_feed :String?
    var reg_type :String?
}

@objcMembers class topic: NSObject {
    var comics_count:String?
    var cover_image_url:String?
    var created_at:String?
    var discover_image_url:String?
    var id:String?
    var label_id:String?
    var male_cover_image_url:String?
    var male_vertical_image_url:String?
    var order:String?
    var status:String?
    var title:String?
    var updated_at:String?
    var user : user?
    var vertical_image_url:String?
    func userinfo() -> NSDictionary {
        return ["user" : user as Any]
    }
}

@objcMembers class kkModel: NSObject {
    var can_view : Bool?
    var comic_type:String?
    var comments_count : String?
    var cover_image_url :String?
    var created_at :String?
    var id :String?
    var info_type:String?
    var  is_free:Bool?
    var  is_liked:Bool?
    var  label_color:String?
    var  label_text:String?
    var  label_text_color:String?
    var  likes_count:String?
    var  push_flag:String?
    var  selling_kk_currency:String?
    var  serial_no:String?
    var  shared_count:String?
    var  status:String?
    var  storyboard_cnt:String?
    var  title:String?
    var  topic : topic?
    var  updated_at:String?
    var  updated_count:String?
    var  url:String?
    var  zoomable:String?
    func comis() -> NSDictionary {
        return ["topic" : topic as Any]
    }
    
    
}


