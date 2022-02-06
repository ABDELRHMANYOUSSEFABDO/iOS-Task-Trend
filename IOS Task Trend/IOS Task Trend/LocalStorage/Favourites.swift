//
//  Favourites.swift
//  IOS Task Trend
//
//  Created by Apple on 2/5/22.
//

import RealmSwift

class Favourites: Object {
    @Persisted var id = ""
    @Persisted var originalImageUrlString = ""
    @Persisted var title = ""
   
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(title: String,image:String,id:String) {
        self.init()
        self.title = title
        self.originalImageUrlString = image
        self.id = id
}
}
