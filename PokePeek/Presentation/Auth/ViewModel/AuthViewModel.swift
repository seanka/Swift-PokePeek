//
//  AuthViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class AuthViewModel: ObservableObject {
    let disposeBag = DisposeBag()
    
    @Published var user: UserRequest = UserRequest(email: "", name: "", password: "")
    @Published var userExist: Bool? = nil
    @Published var statusMessage: String?
    
    @Published var authError: Bool = false
    @Published var emailError: Bool = false
    
    let actionSucceeded = BehaviorRelay<Bool>(value: false)
    
    private let userHelper: UserDataHelper
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
    }
    
    public func resetState() {
        authError = false
        emailError = false
        userExist = nil
        user = UserRequest(email: "", name: "", password: "")
    }
    
    // MARK: - Form Validator
    func validateEmail() {
        guard !user.email.isEmpty else { return }
        
        let pattern = #"""
        (?xi)                                     # allow comments / case-insensitive
        ^(?=.{1,254}$)                             # whole email length
        (?=.{1,64}@)                               # local-part length
        [A-Z0-9._%+-]+(?:\.[A-Z0-9._%+-]+)*        # local part (no leading/trailing dot; no consecutive dots via groups)
        @
        (?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+# domain labels
        [A-Z]{2,}$                                 # TLD
        """#

        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", pattern)

        emailError = !predicate.evaluate(with: user.email)
    }
    
    // MARK: - Check User Existance
    func checkUserExist() {
        guard !user.email.isEmpty else { return }
        
        userExist = userHelper.fetchUser(byEmail: user.email) != nil
    }
    
    // MARK: - Register
    func registerUser() {
        guard !user.email.isEmpty, !user.password.isEmpty, !user.name.isEmpty else { return }
        
        userHelper.saveUser(email: user.email,name: user.name,password: user.password)
        
        actionSucceeded.accept(true)
        resetState()
    }
    
    // MARK: - Login
    func loginUser() {
        if let user = userHelper.validateUser(email: user.email, password: user.password) {
            userHelper.generateToken(for: user)
            
            resetState()
            actionSucceeded.accept(true)
        } else {
            authError = true
        }
    }
}
