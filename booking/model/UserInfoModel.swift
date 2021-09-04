//
//  UserInfoModel.swift
//  booking
//
//  Created by Mr Diep Luu Van Diep on 06/09/2021.
//

import ReactiveCocoa
import ReactiveSwift

class UserInfoModel {
    var name = MutableProperty<String>("")
    var email = MutableProperty<String>("")
    var valid = Property<Bool>(value: false)
    
    init() {
        self.valid = Property.combineLatest(self.name, self.email).map { (name, email) in
            return name.count > 0 && email.count > 0 && self.isValidEmail(email)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func convertToEntity() -> UserInfoEntity {
        return UserInfoEntity(name: self.name.value, email: self.email.value)
    }
}
