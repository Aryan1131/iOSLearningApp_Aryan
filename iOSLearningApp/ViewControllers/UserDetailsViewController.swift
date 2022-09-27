//
//  UserDetailsViewController.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit

class UserDetailsViewController: UIViewController {
    let mainActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var userDetails: User?
    var userDetailsList: [cellModel] = []
    let userDetailsTableView = UITableView()
    let userDetailsViewModel = UserDetailsViewModel()
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        userDetails = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented inside userdetailsviewcontoller")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userDetails?.login
        
        setupMainActivityIndicatorView()
        userDetailsViewModel.userDetailsViewModelDelegate = self
        guard let userDetails = userDetails else {
            return
        }
        userDetailsViewModel.viewDidLoad(user: userDetails)
        func setupMainActivityIndicatorView(){
            mainActivityIndicator.snp.makeConstraints({
                make in
                make.top.bottom.leading.trailing.equalToSuperview()
            })
        }
    }
}

extension UserDetailsViewController: CommonViewLoadModel {
    func showData(_ data: Any) {
        guard let userData = data as? [cellModel] else {
            return
        }
        print("Showing data of users")
        userDetailsList = userData
        print(userData.count)
        userDetailsTableView.reloadData()
    }
    func TableViewSetUp(){
        userDetailsTableView.dataSource = self
        userDetailsTableView.delegate = self
        userDetailsTableView.register(UserDetailsViewCell.self, forCellReuseIdentifier: "UserDetailsTableViewCell")
        userDetailsTableView.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: "ProfileImageTableViewCell")
        userDetailsTableView.separatorStyle = .none
        userDetailsTableView.backgroundColor = ThemeConstants.PRIMARY_BG_COLOR
        userDetailsTableView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        view.addSubview(userDetailsTableView)
        userDetailsTableView.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
    func showLoader(_ show: Bool) {
        if(show){
            mainActivityIndicator.startAnimating()
            
        }else{
            mainActivityIndicator.stopAnimating()
        }
    }
    
    func showError() {
        print("Error form file UserDetailsViewController")
    }

}

extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != 0) {
            let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell", for: indexPath) as! UserDetailsViewCell
            print(userDetailsList)
            let data: cellModel = userDetailsList[indexPath.row]
            cell.setDataUserDetailsViewCell(key: data.leftLabel, value: data.rightLabel)
            return cell
        } else {
            let cell =  userDetailsTableView.dequeueReusableCell(withIdentifier: "ProfileImageTableViewCell", for: indexPath) as! ProfileImageTableViewCell
            cell.setData(imageUrl: userDetails?.avatar_url ?? " ")
            return cell
        }
    }
}


