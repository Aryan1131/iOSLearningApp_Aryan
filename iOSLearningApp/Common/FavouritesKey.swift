//
//  FavouritesKey.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 29/09/22.
//

import Foundation

class Favourites {
    // MARK: 41 no space before function->DONE
    private init() { }
    static let shared = Favourites()
    func getKeyForFavourite(userdId: String)-> String {
        return "favProfile\(userdId)"
    }
    
}

