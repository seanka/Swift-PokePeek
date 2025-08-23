//
//  PasswordResetViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 22/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class PasswordResetViewModel: ObservableObject {
    let disposeBag = DisposeBag()
    
    @Published var password: String = ""
    @Published var loading: Bool = false
    
    private let userHelper: UserDataHelper
    
    let actionSucceeded = BehaviorRelay<Bool?>(value: nil)
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
    }
    
    // MARK: - Reset Password
    func resetPassword(email: String) {
        loading = true
        
        if let user = userHelper.fetchUser(byEmail: email) {
            userHelper.updatePassword(for: user, password: password)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.loading = false
                self.actionSucceeded.accept(true)
            }
        }
    }
}
