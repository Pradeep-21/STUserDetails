//
//  UserModel.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

struct UserDetails: Codable {
    let id, name, email, phone: String
    let gender: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, email, phone, gender
    }
}

/// Use this protocol to managing network available status from view model
protocol NetworkReachableProtocol {
    func isOnline() -> Bool
}

struct NetworkHandler: NetworkReachableProtocol {
    func isOnline() -> Bool {
        Helper.isOnline()
    }
}


protocol UsersListModelProtocol: ResponseBlockProtocol {
    typealias UserSuccessBlock = (_ userDetails: [UserDetails]?) -> Void
    
    func fetchUserList(successBlock: @escaping UserSuccessBlock, failureBlock: @escaping FailureBlock)
}

class UsersListModel: UsersListModelProtocol {
    
    func fetchUserList(successBlock: @escaping UserSuccessBlock, failureBlock: @escaping FailureBlock) {
        _ = NetworkManager.shared.getRequest(url: APIs.getUsers.url, parameters: nil, successBlock: { withResponse in
            if let responseData = withResponse?.data {
                do {
                    let loginDetails = try JSONDecoder().decode([UserDetails].self, from: responseData)
                    successBlock(loginDetails)
                } catch {
                    successBlock(nil)
                }
                return
            }
        }, failureBlock: { response, cancelStatus in
            failureBlock(response, cancelStatus)
        })
    }
    
}
