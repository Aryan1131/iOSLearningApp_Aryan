//
//  FavouritesKey.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 29/09/22.
//

import Foundation

class Favourites {
    static let shared = Favourites()
    private init() { }
    
    func getKeyForFavourite(userdId: String)-> String {
       // print("favProfile\(userdId)")
        return "favProfile\(userdId)"
    }
    
}

