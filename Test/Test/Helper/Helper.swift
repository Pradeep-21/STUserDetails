//
//  Helper.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation
import Alamofire

class Helper {
    
    class func isOnline() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}
