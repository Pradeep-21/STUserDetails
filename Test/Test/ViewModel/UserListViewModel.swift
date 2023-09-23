//
//  UserListViewModel.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

class UserListViewModel {
    
    var userList = Observable<[UserDetails]>()
    
    var networkHandler: NetworkReachableProtocol
    var model: UsersListModelProtocol
    
    // MARK: - Protocol's Properties
    
    var shouldShowLoading = Observable<Bool>()
    var errorMessage = Observable<String>()
    
    init(model: UsersListModelProtocol, networkHandler: NetworkReachableProtocol = NetworkHandler()) {
        self.model = model
        self.networkHandler = networkHandler
    }
    
    // MARK: - Custom Methods
    
    func fetchUserList() {
        if networkHandler.isOnline() {
            shouldShowLoading.value = true
            model.fetchUserList { userDetails in
                self.shouldShowLoading.value = false
                self.userList.value = userDetails
            } failureBlock: { response, cancelStatus in
                self.shouldShowLoading.value = false
                self.errorMessage.value = kFailureMessage
            }
        } else {
            errorMessage.value = kNetworkOfflineMessage
        }
    }
    
}
