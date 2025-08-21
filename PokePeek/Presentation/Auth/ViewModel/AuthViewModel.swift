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
    
    let actionSucceeded = BehaviorRelay<Bool>(value: false)
    
    private let userHelper: UserDataHelper
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
    }
    
    private func resetState() {
        userExist = nil
        user = UserRequest(email: "", name: "", password: "")
    }
    
    // MARK: - Check User Existance
    func checkUserExist() {
        guard !user.email.isEmpty else { return }
        
        userExist = userHelper.fetchUser(byEmail: user.email) != nil
    }
    
    // MARK: - Register
    func registerUser() {
        guard !user.email.isEmpty, !user.password.isEmpty, !user.name.isEmpty else {
            statusMessage = "⚠️ All fields are required"
            return
        }
        
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
            statusMessage = "❌ Invalid email or password"
        }
    }
}
