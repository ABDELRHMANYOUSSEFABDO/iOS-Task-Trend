//
//  DatabaseManager.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Work With Objects
    
    func delete(objects: [Object]) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    // MARK: - Work With favourites
    
    func add(favourites: Favourites,added:@escaping (Bool)->()) {
        do{
            try realm.write {
                realm.add(favourites, update: .modified)
                added(true)
            }
        }catch{
            added(false)

        }
        
       

    }
    func remove(favourite: Favourites) {
        guard  let objects = try?  Realm().objects(Favourites.self) else{
            return
        }
        guard  let favToDelete = objects.filter("id = '\(favourite.id)'").first else{
            return
        }
        try? realm.write {
            realm.delete(favToDelete)
        }
        
    }
    func isFavExist(fav:Favourites)->Bool{
    let allFavs = getAllFav()
        if allFavs.isEmpty {
            return false
        }else{
            guard let _ =   allFavs.filter({$0.id == fav.id}).first else{
                return false
            }
            return true
        }
    }
    func getAllFav()->[Favourites]{
        guard  let objects = try?  Realm().objects(Favourites.self).toArray(ofType: Favourites.self) as [Favourites]else{
            return []
        }
        return objects
    }
    
}
extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }

        return array
    }
}
