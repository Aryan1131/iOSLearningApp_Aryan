//
//  Constant.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

struct APIConstants {
    static var SCHEME="https"
    static var METHOD=HTTPMethod.GET
    static var BASE_URL="api.github.com"
    static var PULL_REQUEST_PATH="/repos/apple/swift/pulls"
    static var PULL_REQUEST_PAGE_SIZE=10
    static var USER_DETAIL_PATH="/users"
}

struct ThemeConstants {
    static var PRIMARY_COLOR=UIColor.black
    static var SECONDARY_COLOR=UIColor.gray
    static var PRIMARY_BG_COLOR=UIColor.black
    static var SECONDARY_BG_COLOR=UIColor.white
    static var MARGIN:CGFloat=15
    static var CORNER_RADIUS:CGFloat=15
    static var IMAGE_WIDTH:CGFloat=100
    static var IMAGE_HEIGHT:CGFloat=100
    static var PRIMARY_FONT_SIZE:CGFloat=12
    static var TITLE_FONT_SIZE:CGFloat=16
    static var SUBTITLE_FONT_SIZE:CGFloat=10
    static var TABLE_VIEW_TITLE="API Requests"
}


struct UserDetailConstants {
    static var DETAIL_COUNT = 6
}
