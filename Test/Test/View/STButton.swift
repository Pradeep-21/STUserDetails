//
//  STButton.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class STButton: UIButton {

    // MARK: - Initializer methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customise()
    }
    
    // MARK: - Custom methods
    
    func customise() {
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = frame.height / 2
    }

}

