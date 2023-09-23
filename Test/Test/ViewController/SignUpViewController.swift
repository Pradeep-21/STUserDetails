//
//  SignUpViewController.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class SignUpViewController: ViewController {

    @IBOutlet weak private var emailTextField: STTextField!
    @IBOutlet weak private var genderTextField: STTextField!
    @IBOutlet weak private var phoneTextField: STTextField!
    @IBOutlet weak private var nameTextField: STTextField!
    @IBOutlet weak private var submitButton: STButton!
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    var isEditMode: Bool?
    var user: UserDetails?
    
    private let viewModel = SignUpViewModel(model: UsersDetailsModel())
    
    // MARK: - Init Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        addBinding()
        if isEditMode == true { setBarButtons() }
    }
    
    private func setBarButtons() {
        let saveButton = UIBarButtonItem(title: kEditButton, style: .plain, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    // MARK: - Action Methods
    
    @objc func editButtonTapped() {
        let isEdit = navigationItem.rightBarButtonItem?.title == kEditButton ? true : false
        navigationItem.rightBarButtonItem?.title = isEdit ? kCancelButton : kEditButton
        enableTextField(enable: isEdit)
        submitButton.isHidden = !isEdit
        isEdit ? () : updateUserDetails()
        submitButton.setTitle(kUpdateButton, for: .normal)
    }
    
    @IBAction func didPressSubmitButton(_ sender: Any) {
        // Here we ask viewModel to update model with existing credentials from text fields
        viewModel.updateCredentials(userName: nameTextField.text, userEmail: emailTextField.text, userPhone: phoneTextField.text, userGender: genderTextField.text)
        
        // Here we check user's input - if it's correct we call create new user.
        switch viewModel.validateUserInput() {
        case .correct:
            if isEditMode == true {
                viewModel.updateUserDetails(id: user?.id ?? "")
            } else {
                viewModel.createNewUser()
            }
        case .incorrect:
            return
        }
    }
    
    // MARK: - Custom Methods
    
    private func addBinding() {
        viewModel.alertMessage.bind { [weak self] message in
            guard let self else { return }
            self.presentAlert(title: "", message: message ?? kDefaultString) {
                if self.viewModel.isSuccessResponse == true {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        viewModel.shouldShowLoading.bind { [weak self] shouldLoad in
            guard let self else { return }
            if shouldLoad == true {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func updateUI() {
        enableTextField(enable: isEditMode == true ? false : true)
        isEditMode == true ? updateUserDetails() : ()
        
        activityIndicator.hidesWhenStopped = true
        
        // Submit button UI
        submitButton.isHidden = isEditMode == true ? true : false
        navigationItem.title = isEditMode == true ? "User Details" : "Create User"
    }
    
    private func updateUserDetails() {
        emailTextField.text = user?.email
        nameTextField.text = user?.name
        phoneTextField.text = user?.phone
        genderTextField.text = user?.gender
    }
    
    private func enableTextField(enable: Bool) {
        emailTextField.isUserInteractionEnabled = enable
        nameTextField.isUserInteractionEnabled = enable
        phoneTextField.isUserInteractionEnabled = enable
        genderTextField.isUserInteractionEnabled = enable
    }
    
}
