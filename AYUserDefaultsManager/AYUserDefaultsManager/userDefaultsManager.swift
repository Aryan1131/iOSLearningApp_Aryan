//
//  userDefaultsManager.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 04/10/22.
//

import Foundation

public class UserDefaultsManager {
    
    public static let shared = UserDefaultsManager()

    private init() {}
    
    public func saveData(Value: String, Key: String) {
        UserDefaults.standard.set(Value, forKey: Key)
    }
    
    public func getData(Key: String) -> Bool {
        if UserDefaultsManager.shared.getData(Key: Key) == nil {
            return false
        } else {
            return true
        }
    }
    
    public func deletedata(Key: String) {
        UserDefaults.standard.removeObject(forKey: Key)
    }
    
}
