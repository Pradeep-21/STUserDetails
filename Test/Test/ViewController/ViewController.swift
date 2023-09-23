//
//  ViewController.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Init Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action Methods

    @IBAction func didPressSignupButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Storyboard.main.name, bundle: nil)
        guard let signupVC = storyBoard.instantiateViewController(withIdentifier: String(describing: SignUpViewController.self)) as? SignUpViewController else { return }
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Storyboard.main.name, bundle: nil)
        guard let listVC = storyBoard.instantiateViewController(withIdentifier: String(describing: UserListViewController.self)) as? UserListViewController else { return }
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func didPressLocationButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: Storyboard.main.name, bundle: nil)
        guard let locationVC = storyBoard.instantiateViewController(withIdentifier: String(describing: LocationViewController.self)) as? LocationViewController else { return }
        navigationController?.pushViewController(locationVC, animated: true)
    }
    
    // MARK: - Custom Methods
    
    func presentAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let okButton = UIAlertAction(title: kOkButton, style: .default, handler: { action in
            completion?()
        })
        alert.addAction(okButton)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
    
}
