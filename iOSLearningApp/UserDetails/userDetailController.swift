//  UserDetailsViewModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit
import AYNetworkManager


class userDetailController {
    
    var userDetailsViewModelDelegate: (CommonViewLoadModel)?
    private var userDetails: User? = nil
    private var cellViewModels: [cellModel] = []
    
    func setResponseData() {
        if let name = userDetails?.name {
            let model = cellModel(leftLabel: userResponseConstants.name, rightLabel: name)
            cellViewModels.append(model)
        }
        
        if let email = userDetails?.email {
            let model = cellModel(leftLabel: userResponseConstants.email, rightLabel: email)
            cellViewModels.append(model)
        }
        
        if let type = userDetails?.type {
            let model = cellModel(leftLabel: userResponseConstants.type, rightLabel: type)
            cellViewModels.append(model)
        }
        
        if let company = userDetails?.company {
            let model = cellModel(leftLabel: userResponseConstants.company, rightLabel: company)
            cellViewModels.append(model)
        }
        
        if let repos = userDetails?.public_repos {
            let model = cellModel(leftLabel: userResponseConstants.number_of_repos, rightLabel: String(repos))
            cellViewModels.append(model)
        }
        if let followers = userDetails?.followers {
            let model = cellModel(leftLabel: userResponseConstants.number_of_follower, rightLabel: String(followers))
            cellViewModels.append(model)
        }
        if let following = userDetails?.following {
            let model = cellModel(leftLabel: userResponseConstants.number_of_following, rightLabel: String(following))
            cellViewModels.append(model)
        }
    }
    
    func viewDidLoad(user: User) {
        userDetailsViewModelDelegate?.showLoader(true)
        if let userName = user.login{
            NetworkManager.shared.fetchData(UserDetailApi(username: userName),completionHandler:{
                (userResponse: User) in
                self.userDetails = userResponse
                self.setResponseData()
                self.userDetailsViewModelDelegate?.showLoader(false)
                self.userDetailsViewModelDelegate?.tableViewSetUp()
                self.userDetailsViewModelDelegate?.showData(self.cellViewModels as Any)
            })
        }
    }
}
