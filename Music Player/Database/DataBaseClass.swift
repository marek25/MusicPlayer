//
//  DataBaseClass.swift
//  Music Player
//
//  Created by OSX on 2/17/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import Foundation
import SQLite3

class DataBase {
    
    var id : Int
    var name : String?
    var url : String?
    
    init(id:Int, name: String?, url: String?) {
        self.id=id
        self.name=name
        self.url=url
    }
    
    deinit {
        print("DataBase deinitialized")
    }
    
}


struct DB {
    var id : Int
    var name : String?
    var url : String?
}
