//
//  APIRequestModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation

struct pullRequest: Decodable {
    let id: Double?
    let title: String?
    var user: User?
    let body: String?
    let state: String?
}
