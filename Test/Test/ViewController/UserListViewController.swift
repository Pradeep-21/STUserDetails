//
//  UserListViewController.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class UserListViewController: ViewController {
    
    @IBOutlet weak private var userListTableView: UITableView!
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    
    private let viewModel = UserListViewModel(model: UsersListModel())

    // MARK: - Init Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBinding()
        registerNib()
        cutomise()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUserList()
    }
    
    // MARK: - Custom Methods
    
    private func cutomise() {
        activityIndicatorView.hidesWhenStopped = true
    }
    
    private func registerNib() {
        userListTableView.register(UINib(nibName: String(describing: UsersTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UsersTableViewCell.self))
        userListTableView.delegate = self
        userListTableView.dataSource = self
    }
    
    private func addBinding() {
        viewModel.userList.bind { _ in
            DispatchQueue.main.async {
                self.userListTableView.reloadData()
            }
        }
        viewModel.shouldShowLoading.bind { shouldLoad in
            if shouldLoad == true {
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
        }
        viewModel.errorMessage.bind { errorMessage in
            self.presentAlert(title: "", message: errorMessage ?? kDefaultString)
        }
    }

}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.userList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UsersTableViewCell.self), for: indexPath) as? UsersTableViewCell else { return UITableViewCell() }
        cell.update(user: viewModel.userList.value?[indexPath.row])
        return cell
    }
    
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: Storyboard.main.name, bundle: nil)
        guard let signupVC = storyBoard.instantiateViewController(withIdentifier: String(describing: SignUpViewController.self)) as? SignUpViewController else { return }
        signupVC.isEditMode = true
        signupVC.user = viewModel.userList.value?[indexPath.row]
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
}
