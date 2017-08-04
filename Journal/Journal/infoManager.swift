//
//  infoManager.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import Foundation

struct JournalInfo {
    var title: String
    var content: String
    var photo: NSData
    var id: Int
}

protocol infoManagerDelegate:class {
    func manager(didGet journalInfo: Entity)
}


