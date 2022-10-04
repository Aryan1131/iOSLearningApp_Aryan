//
//  GenericAPI.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 26/09/22.
//

import Foundation

protocol API {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

extension API {
    var scheme: String {
        return APIConstants.SCHEME
    }
    var baseUrl: String {
        return APIConstants.BASE_URL
    }
    var method: HTTPMethod {
        return .GET
    }
    var headers: [String: String]? {
        return nil
    }
    var body: [String: String]? {
        return nil
    }
}
