//
//  channelModel.swift
//  motaDemo
//
//  Created by wang on 2018/9/6.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit


//频道的模型参数,需要添加@objc修饰,
class channelModel: NSObject {
   @objc var channel_id : String?
   @objc var name       :String?
   @objc var abbr_en    :String?
   @objc var name_en    :String?
   @objc var seq_id     :String?
}
