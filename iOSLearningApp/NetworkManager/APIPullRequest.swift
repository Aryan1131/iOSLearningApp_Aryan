//
//  APIPullRequest.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import AYNetworkManager


struct APIPullRequest : API {
    let PageNumber: Int
    let PageSize: Int = APIConstants.PULL_REQUEST_PAGE_SIZE
    
    var path: String {
        return APIConstants.PULL_REQUEST_PATH
    }
    
    var queryParams: [String : String]? {
        return ["page": "\(PageNumber)", "per_page": "\(PageSize )"]
    }
}
