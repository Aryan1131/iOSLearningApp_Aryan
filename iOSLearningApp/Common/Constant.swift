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
    static var PRIMARY_BG_COLOR=UIColor.white
    static var SECONDARY_BG_COLOR=UIColor.black
    static var MARGIN:CGFloat=15
    static var CORNER_RADIUS:CGFloat=15
    static var IMAGE_WIDTH:CGFloat=100
    static var IMAGE_HEIGHT:CGFloat=100
    static var PRIMARY_FONT_SIZE:CGFloat=12
    static var TITLE_FONT_SIZE:CGFloat=16
    static var SUBTITLE_FONT_SIZE:CGFloat=10
    static var TABLE_VIEW_TITLE="API Requests"
    static var SPINNER_DIAMETER = 2
    
}


struct userDetailConstants {
    static var DETAIL_COUNT = 6
    static var USER = "user"
}

struct notificationConstants {
    static var Observer = "observer"
    static var Listener = "listiner"
}

struct alertConstants {
    static var cancel = "cancel"
    static var ok = "OK"
    static var bookmarkAlertTitle = "Bookmarked"
    static var bookmarkAlertMessage = "Want to bookmark this user ?"
    static var unMarkAlertTitle = "Un-Marked"
    static var unMarkAltertMessage = "User profile removed from bookmark"
    static var bookmarkTitle = "Bookmark"
}

struct userResponseConstants {
    static var name = "Name"
    static var email = "Email"
    static var type = "Type"
    static var company = "Company"
    static var number_of_repos = "Number of Repos"
    static var number_of_follower = "Follower Counts"
    static var number_of_following = "Following Counts"
}

struct errorConstants {
    static var fatalerror = "init(coder:) has not been implemented"
    static var error = "Error"
    static var encodeFailError = "Failed to encode data"
}
