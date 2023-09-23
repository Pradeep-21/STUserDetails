//
//  UsersTableViewCell.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var phoneLabel: UILabel!
    @IBOutlet weak private var genderLabel: UILabel!
    @IBOutlet weak private var emailLabel: UILabel!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var userImageView: UIImageView!
    
    // MARK: - Init Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customiseUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Custom Methods
    
    private func customiseUI() {
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
    func update(user: UserDetails?) {
        nameLabel.text = user?.name ?? kDefaultString
        emailLabel.text = user?.email ?? kDefaultString
        genderLabel.text = user?.gender ?? kDefaultString
        phoneLabel.text = user?.phone ?? kDefaultString
    }
    
}
