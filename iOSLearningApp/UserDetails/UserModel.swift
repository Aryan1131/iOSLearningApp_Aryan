//
//  UserModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//
// MARK: 36 space between import lines ->DONE

import Foundation
import UIKit
struct User: Decodable, Encodable {
    let id: Double?
    let login: String?
    let type: String?
    let avatar_url: String?
    let name: String?
    let company: String?
    let location: String?
    let email: String?
    let hireable: Bool?
    let bio: String?
    let twitter_username: String?
    let public_repos: Int?
    let public_gists: Int?
    let followers: Int?
    let following: Int?
}


struct cellModel {
    let leftLabel: String
    let rightLabel: String
}
