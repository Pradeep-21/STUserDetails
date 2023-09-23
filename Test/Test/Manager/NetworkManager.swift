//
//  NetworkManager.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit
import Alamofire

protocol ResponseBlockProtocol {
    typealias SuccessBlock = (_ withResponse: AFDataResponse<Any>?) -> Void
    typealias FailureBlock = (_ response: AFDataResponse<Any>?, _ cancelStatus: Bool?) -> Void
}

protocol AlamofireProtocol: ResponseBlockProtocol {
    func requestFromServer(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request
    
    func postRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request
    func getRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request
    func putRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request
}

class NetworkManager: NSObject, AlamofireProtocol {
    
    static var httpHeaders: HTTPHeaders = ["Content-Type": "application/json"]
    static let shared: NetworkManager = NetworkManager()
    
    private override init() {}
    
    func requestFromServer(url: URL, httpMethod: HTTPMethod, parameters: [String: Any]?, encoding: ParameterEncoding, headers: HTTPHeaders?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request {
        
        
        return AF.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
            if let statusCode = response.response?.statusCode, 200...300 ~= statusCode {
                successBlock(response)
            } else {
                // To validate failureBlock
                failureBlock(response, false)
            }
        }
    }
    
    // MARK: - Request Methods
    
    @discardableResult
    func postRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request {
        return requestFromServer(url: url, httpMethod: .post, parameters: parameters, encoding: JSONEncoding.default, headers: NetworkManager.httpHeaders, successBlock: successBlock, failureBlock: failureBlock)
    }
    
    @discardableResult
    func getRequest(url: URL, parameters: [String : Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Alamofire.Request {
        return requestFromServer(url: url, httpMethod: .get, parameters: nil, encoding: JSONEncoding.default, headers: NetworkManager.httpHeaders, successBlock: successBlock, failureBlock: failureBlock)
    }
    
    @discardableResult
    func putRequest(url: URL, parameters: [String: Any]?, successBlock: @escaping SuccessBlock, failureBlock: @escaping FailureBlock) -> Request {
        return requestFromServer(url: url, httpMethod: .put, parameters: parameters, encoding: JSONEncoding.default, headers: NetworkManager.httpHeaders, successBlock: successBlock, failureBlock: failureBlock)
    }
   
}
