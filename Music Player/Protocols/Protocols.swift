//
//  Protocols.swift
//  Music Player
//
//  Created by OSX on 2/10/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import Foundation
import UIKit





protocol FetchingProtocol {
    var html : String {get set}
    
    var URLStringForSession : String {get set}
    func dataFetcher(url: String)
}




//enum UIUserInterfaceIdiom : Int {
//    case unspecified
//    
//    case phone // iPhone and iPod touch style UI
//    case pad // iPad style UI
//}




