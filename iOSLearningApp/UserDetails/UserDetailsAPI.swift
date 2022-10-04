//
//  UserDetailsAPI.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//
// MARK: 35 no empty line after import ->DONE
import Foundation
struct UserDetailApi: API {
    let username: String
        
    var path: String {
        return APIConstants.USER_DETAIL_PATH + "/\(username)"
    }
    
    var queryParams: [String : String]? {
        return nil
    }
    
}



