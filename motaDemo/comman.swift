//
//  comman.swift
//  motaDemo
//
//  Created by wang on 2018/9/6.
//  Copyright © 2018年 wang. All rights reserved.
//这里可以存放公共参数,或者公共函数,头文件有的卸载这里就可以,其他不用再写,但有的就不可以

import Foundation
import UIKit


///屏幕宽度
let KScreenWidth = UIScreen.main.bounds.size.width;
///屏幕高度
let KScreenHeight = UIScreen.main.bounds.size.height;

//相当于OC中的宏,可以使用汉字
public let 频道 = "j/app/radio/channels"
public let HOSTAPI = "https://www.douban.com/"

///返回一个颜色

func hexColor(hex:NSInteger) -> UIColor {
    let r = (hex >> 16) & 0xFF
    let g = (hex >> 8) & 0xFF;
    let b = (hex) & 0xFF;
    return UIColor.init(red: CGFloat(r/255), green: CGFloat(g/255), blue: CGFloat(b/255), alpha: 1.0)
}
//类扩展,swift中没有了分类,用这个替换
extension String {
    /// 判断是否是手机号
    func isPhoneNumber() -> Bool {
        let pattern = "^1[345789]\\d{9}$"
        return NSPredicate.init(format:"SELF MATCHES %@",pattern).evaluate(with: self)
    }
}

