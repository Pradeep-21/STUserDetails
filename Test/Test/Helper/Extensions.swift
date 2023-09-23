//
//  Extensions.swift
//  Test
//
//  Created by Pradeep Selvaraj on 23/09/23.
//

import Foundation

extension String {
    
    func isEmptyString() -> Bool {
        let text = trimmingCharacters(in: .whitespacesAndNewlines)
        return text.isEmpty
    }
    
    func isValidEmail() -> Bool {
        let email = trimmingCharacters(in: .whitespacesAndNewlines)
        let kEmailValidation = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return kEmailValidation.evaluate(with: email)
    }
    
    func isValidPhone() -> Bool {
        let phone = trimmingCharacters(in: .whitespacesAndNewlines)
        let kPhoneValidation = NSPredicate(format:"SELF MATCHES %@", "[0-9]{1,}")
        return kPhoneValidation.evaluate(with: phone)
    }
    
}
