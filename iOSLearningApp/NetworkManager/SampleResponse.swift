//
//  File.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 29/09/22.
//

import Foundation
struct SampleResponse: Decodable,Encodable {
    var items: [Item]?
}
struct Item: Decodable,Encodable{
    var id: Double?
    var title: String?
    var user: Users?
    var body: String?
}
struct Users: Decodable,Encodable{
    var id: Double?
    var type: String?
    var login: String?
    var avatar_url: String?
}
