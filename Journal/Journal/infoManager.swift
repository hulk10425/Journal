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
    var photo: UIImage
}

protocol infoManagerDelegate:class {
    func manager(image: , _controller: ViewController)
    
   // func manager(_ manager: OrderManager, didFailWith error: Error )
    
}

class OrderManager {
    weak var delegate: OrderManagerDelegate?
    func getcontroller () {
        self.delegate?.manager(<#T##manager: OrderManager##OrderManager#>, _controller: <#T##ViewController#>)
    }
    
}
