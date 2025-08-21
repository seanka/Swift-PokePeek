//
//  ProfileViewModel.swift
//  PokePeek
//
//  Created by Sean Anderson on 21/08/25.
//

import Foundation
import RxSwift
import RxRelay

final class ProfileViewModel: ObservableObject {
    let disposeBag = DisposeBag()
    
    @Published var userData: UserEntity?
    
    let userShouldLogin = BehaviorRelay<Bool>(value: false)
    
    private let userHelper: UserDataHelper
    
    init(userHelper: UserDataHelper) {
        self.userHelper = userHelper
        
        self.userData = userHelper.fetchLoggedUser()
    }
    
    // MARK: - Fetch User Data
    func fetchUserData() {
        guard let userData else {
            userShouldLogin.accept(true)
            return
        }
        
        if !userHelper.checkTokenValidity(for: userData) {
            userShouldLogin.accept(true)
            userHelper.invalidateToken(for: userData)
        }
    }
    
    // MARK: - Logout
    func logoutUser() {
        guard let userData else { return }
        
        userShouldLogin.accept(true)
        userHelper.invalidateToken(for: userData)
    }
}
