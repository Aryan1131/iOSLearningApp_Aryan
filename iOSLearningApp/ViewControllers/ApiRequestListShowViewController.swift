//
//  ApiRequestListShowViewController.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation

import UIKit
import SnapKit

class APIRequestListShowViewController: UIViewController, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    , UITableViewDelegate
    
    
    var APIRequestResponse: [APIRequest]=[]
    let UsersDataListTable = UITableView()
    let APIRequestViewModel = APIRequestListViewModel()
    let mainActivityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupMainActivityIndicatorView()
        navigationController?.navigationBar.isTranslucent = false
        self.title = ThemeConstants.TABLE_VIEW_TITLE
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        APIRequestViewModel.APIRequestView = self
        APIRequestViewModel.APIRequestListViewModelviewDidLoad()
    }
    func setupMainActivityIndicatorView() {
        mainActivityIndicatorView.color = ThemeConstants.PRIMARY_COLOR
        view.addSubview(mainActivityIndicatorView)
        mainActivityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
}

extension APIRequestListShowViewController : CommonViewLoadModel{
    
    func showLoader(_ show: Bool) {
        if(show == true) {
            mainActivityIndicatorView.startAnimating()
            print("Showing loader true")
        } else {
            mainActivityIndicatorView.stopAnimating()
            print("Showing loader false")
        }
    }
    
    func showError() {
        print("Error inSide APIRequestListShowViewController ")
    }
    
    func showData(_ show: Any) {
        
        guard let data = data as? [APIRequest] else {
            return
        }
        print("Showing data")
        APIRequestResponse = data
        print(data.count)
        UsersDataListTable.reloadData()
    }
    
    func TableViewSetUp() {
        print("table setup")
        UsersDataListTable.dataSource = self
        UsersDataListTable.delegate = self
        UsersDataListTable.register(APIRequestListShowViewController.self, forCellReuseIdentifier: "PullRequestListTableViewCell")
        UsersDataListTable.register(LoaderTableViewCell.self, forCellReuseIdentifier: "LoaderTableViewCell")
        UsersDataListTable.separatorStyle = .none
        UsersDataListTable.backgroundColor = .lightGray
        UsersDataListTable.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        view.addSubview(UsersDataListTable)
        UsersDataListTable.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
}

extension APIRequestListShowViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequestResponse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < pullRequestResponse.count) {
            let cell = pullRequestListTableView.dequeueReusableCell(withIdentifier: "PullRequestListTableViewCell", for: indexPath) as! PullRequestListTableViewCell
            let item = pullRequestResponse[indexPath.row]
            cell.setData(item: item)
            return cell
        } else {
            let cell = pullRequestListTableView.dequeueReusableCell(withIdentifier: "LoaderTableViewCell", for: indexPath) as! LoaderTableViewCell
            cell.showLoader(true)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected \(indexPath.row)")
        if let user = pullRequestResponse[indexPath.row].user {
            self.navigationController?.pushViewController(UserDetailViewController(user: user), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("\(pullRequestResponse.count) : \(indexPath.row)")
        if pullRequestResponse.count == indexPath.row + 2 {
            pullRequestViewModel.reachedBottom()
        }
    }
}


    

