//
//  UIColor+Extension.swift
//  Record
//
//  Created by Aoi Saito on 2019/07/05.
//  Copyright © 2019年 Aoi Saito. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(code: String) {
        var color: UInt32 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if Scanner(string: code.replacingOccurrences(of: "#", with: "")).scanHexInt32(&color) {
            r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            b = CGFloat( color & 0x0000FF       ) / 255.0
        }
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    static var blue: UIColor {
        return UIColor(code: "#1e90ff")
    }
    
    static var pink: UIColor {
        return UIColor(code: "#ff008e")
    }
    
    static var green: UIColor {
        return UIColor(code: "#359E55")
    }
    
    static var yellow: UIColor {
        return UIColor(code: "#ffd700")
    }
}
