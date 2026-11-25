//
//  Utilities.swift
//  Cydia
//
//  Created by Abraham Masri on 12/1/16.
//  Copyright © 2016 Abraham Masri. All rights reserved.
//

import Foundation
import UIKit

// Application name
let appName = "Cydia"

// Version of this Cydia
let cydiaVersion = "1.1.3"

func getDeviceModel() -> String {
    var sysinfo = utsname()
    uname(&sysinfo)
    let machine = Mirror(reflecting: sysinfo.machine).children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else { return identifier }
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    return machine
}

func getSystemVersion() -> String {
    return UIDevice.current.systemVersion
}
