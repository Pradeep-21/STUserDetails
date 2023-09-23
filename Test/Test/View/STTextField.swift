//
//  STTextField.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import UIKit

class STTextField: UITextField {
    
    // MARK: - Initializer methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customise()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customise()
    }
    
    // MARK: - Custom methods
    
    /// Corner radius change to be 5 for clear view
    private func customise() {
        layer.cornerRadius = 5
    }
    
    /// Set the padding the text field
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 10
    )

    /// Padding the text in the text field
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}

