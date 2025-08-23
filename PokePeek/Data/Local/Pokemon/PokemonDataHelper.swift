//
//  PokemonDataHelper.swift
//  PokePeek
//
//  Created by Sean Anderson on 23/08/25.
//

import CoreData

final class PokemonDataHelper {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Fetch PokeList
    func fetchPokeList(offset: Int, limit: Int) -> [Pokemon]? {
        let request: NSFetchRequest<PokeEntity> = PokeEntity.fetchRequest()
        request.fetchOffset = offset
        request.fetchLimit = limit
        
        do {
            let results = try context.fetch(request)
            return results.map { entity in
                Pokemon(
                    name: entity.name ?? "",
                    url: entity.url ?? ""
                )
            }
        } catch {
            return []
        }
    }
    
    // MARK: - Overwrite PokeList
    // Delete existing pokelist and save new pokelist
    func overwriteList(with list: [Pokemon]) {
        let request: NSFetchRequest<NSFetchRequestResult> = PokeEntity.fetchRequest()
        
        deletePokeList(request: request)
        
        for pokemon in list {
            let pokeEntity = PokeEntity(context: context)
            pokeEntity.name = pokemon.name
            pokeEntity.url = pokemon.url
            pokeEntity.lastUpdate = Date()
        }
        
        saveContext()
    }
    
    private func deletePokeList(request: NSFetchRequest<NSFetchRequestResult>) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try? context.execute(deleteRequest)
    }
    
    // MARK: - Update PokeList
    // Append when poke not exist, Update data when exist
    func updatePokeList(with list: [Pokemon]) {
        for pokemon in list {
            let request: NSFetchRequest<PokeEntity> = PokeEntity.fetchRequest()
            request.predicate = NSPredicate(format: "name == %d", pokemon.name ?? "")

            if let existing = try? context.fetch(request).first {
                existing.name = pokemon.name
                existing.url = pokemon.url
                existing.lastUpdate = Date()
            } else {
                let entity = PokeEntity(context: context)
                entity.name = pokemon.name
                entity.url = pokemon.url
                entity.lastUpdate = Date()
            }
        }
        saveContext()
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
