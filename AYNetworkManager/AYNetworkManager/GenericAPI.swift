//
//  GenericAPI.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 26/09/22.
//

import Foundation

public protocol API {
    var scheme: String { get }
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParams: [String: String]? { get }
    var headers: [String: String]? { get }
    var body: [String: String]? { get }
}

public extension API {
    var scheme: String {
        return "http"
        //MARK: Need to clean
        //return "APIConstants.SCHEME"
    }
    var baseUrl: String {
        return "api.github.com"
        //return "APIConstants.BASE_URL"
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

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

