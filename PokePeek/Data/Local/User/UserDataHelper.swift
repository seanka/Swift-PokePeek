//
//  UserDataHelper.swift
//  PokePeek
//
//  Created by Sean Anderson on 20/08/25.
//

import Foundation
import CoreData
import SwiftUI

final class UserDataHelper {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Save User (New User Creation)
    func saveUser(id: UUID = UUID(), email: String, name: String, password: String) {
        let user = UserEntity(context: context)
        user.id = id
        user.email = email
        user.name = name
        user.password = password
        user.createdAt = Date()
        
        saveContext()
    }
    
    // MARK: - Fetch User
    func fetchUser(byEmail email: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch user: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchLoggedUser() -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "validToken != nil")
        
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to fetch logged user: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Validate Login
    func validateUser(email: String, password: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("❌ Failed to validate user: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Update Password
    func updatePassword(for user: UserEntity, password: String) {
        user.password = password
        try? context.save()
    }
    
    // MARK: - Token
    func generateToken(for user: UserEntity) {
        user.validToken = Date().addingTimeInterval(5 * 60)
        try? context.save()
    }
    
    func checkTokenValidity(for user: UserEntity) -> Bool {
        guard let token = user.validToken else { return false }
        return token > Date()
    }

    func invalidateToken(for user: UserEntity) {
        user.validToken = nil
        try? context.save()
    }
    
    // MARK: - Save Context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ Failed to save context: \(error.localizedDescription)")
            }
        }
    }
}
