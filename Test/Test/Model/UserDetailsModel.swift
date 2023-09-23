//
//  UserDetailsModel.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

protocol UsersDetailsModelProtocol: ResponseBlockProtocol {
    func createUser(userName: String, email: String, phone: String, gender: String, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock)
    func updateUser(id: String, userName: String, email: String, phone: String, gender: String, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock)
}

class UsersDetailsModel: UsersDetailsModelProtocol {
    
    func createUser(userName: String, email: String, phone: String, gender: String, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) {
        let parameter: [String: Any] = ["name": userName, "email": email, "phone": phone, "gender": gender]
        
        _ = NetworkManager.shared.postRequest(url: APIs.createUsers.url, parameters: parameter, successBlock: { withResponse in
            successBlock(nil)
        }, failureBlock: { response, cancelStatus in
            failureBlock(response, cancelStatus)
        })
    }
    
    func updateUser(id: String, userName: String, email: String, phone: String, gender: String, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) {
        let parameter: [String: Any] = ["name": userName, "email": email, "phone": phone, "gender": gender]
        guard let path = URL(string: "\(APIs.updateUsers.url)/\(id)") else { return }
        
        _ = NetworkManager.shared.putRequest(url: path, parameters: parameter, successBlock: { withResponse in
            successBlock(nil)
        }, failureBlock: { response, cancelStatus in
            failureBlock(response, cancelStatus)
        })
    }
    
}
