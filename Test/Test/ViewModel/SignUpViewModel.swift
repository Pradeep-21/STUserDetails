//
//  SignUpViewModel.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

protocol SignUpProtocol {
    func createNewUser()
}

class SignUpViewModel: SignUpProtocol {
    
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var gender: String = ""
    
    var networkHandler: NetworkReachableProtocol
    var model: UsersDetailsModelProtocol
    var isSuccessResponse: Bool?
    
    init(model: UsersDetailsModel, networkHandler: NetworkReachableProtocol = NetworkHandler()) {
        self.model = model
        self.networkHandler = networkHandler
    }
    
    // MARK: - Protocol's Properties
    
    var shouldShowLoading = Observable<Bool>()
    var alertMessage = Observable<String>()
    
    // MARK: - Custom Methods
    
    func createNewUser() {
        if networkHandler.isOnline() {
            shouldShowLoading.value = true
            model.createUser(
                userName: name,
                email: email,
                phone: phone,
                gender: gender) { _ in
                    self.shouldShowLoading.value = false
                    self.isSuccessResponse = true
                    self.alertMessage.value = kSuccessCreateMessage
                } failureBlock: { _, _ in
                    self.isSuccessResponse = false
                    self.shouldShowLoading.value = false
                    self.alertMessage.value = kFailureMessage
                }
        } else {
            alertMessage.value = kNetworkOfflineMessage
        }
    }
    
    func updateUserDetails(id: String) {
        if networkHandler.isOnline() {
            shouldShowLoading.value = true
            model.updateUser(
                id: id,
                userName: name,
                email: email,
                phone: phone,
                gender: gender) { _ in
                    self.shouldShowLoading.value = false
                    self.isSuccessResponse = true
                    self.alertMessage.value = kSuccessUpdateMessage
                } failureBlock: { _, _ in
                    self.isSuccessResponse = false
                    self.shouldShowLoading.value = false
                    self.alertMessage.value = kFailureMessage
                }
        } else {
            alertMessage.value = kNetworkOfflineMessage
        }
    }
    
    /**Here we update our user's details*/
    func updateCredentials(userName: String?, userEmail: String?, userPhone: String?, userGender: String?) {
        name = userName ?? ""
        email = userEmail ?? ""
        phone = userPhone ?? ""
        gender = userGender ?? ""
    }
    
    /**
     Validation for user inputs user name and password
     - Returns: Return the user input validation status.
     */
    func validateUserInput() -> UserInputStatus {
        if name.isEmptyString() {
            alertMessage.value = NSLocalizedString("InvalidUserName", comment: "Empty credential")
            return .incorrect
        }
        if !email.isValidEmail() {
            alertMessage.value = NSLocalizedString("InvalidEmail", comment: "Empty credential")
            return .incorrect
        }
        if !phone.isValidPhone() {
            alertMessage.value = NSLocalizedString("InvalidPhone", comment: "Empty credential")
            return .incorrect
        }
        if gender.isEmptyString() {
            alertMessage.value = NSLocalizedString("InvalidGender", comment: "Empty credential")
            return .incorrect
        }
        return .correct
    }
    
}
