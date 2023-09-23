//
//  Enumerations.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

// URL path
#if DEBUG
let kBaseURL = "https://crudcrud.com/api/e0ab6f12a5ca4f5bb296f4ab061ba7e1"
#elseif RELEASE
let kBaseURL = "https://crudcrud.com/api/e0ab6f12a5ca4f5bb296f4ab061ba7e1"
#else
let kBaseURL = "https://crudcrud.com/api/e0ab6f12a5ca4f5bb296f4ab061ba7e1"
#endif

enum APIs {
    case createUsers
    case getUsers
    case updateUsers
    
    var urlString: String {
        switch self {
        case .createUsers:
            return "\(kBaseURL)/users"
        case .getUsers:
            return "\(kBaseURL)/users"
        case .updateUsers:
            return "\(kBaseURL)/users"
        }
    }
    
    var url: URL {
        // swift lint:disable force_unwrapping
        return URL(string: urlString)! // Force unwrap doesn't cause any impact
        // swift lint:enable force_unwrapping
    }
}

enum Storyboard {
    case main
    
    var name: String {
        switch self {
        case .main:
            return "Main"
        }
    }
}

enum UserInputStatus {
    case correct
    case incorrect
}
