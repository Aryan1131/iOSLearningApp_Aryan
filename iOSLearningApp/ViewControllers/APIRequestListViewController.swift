//
//  APIRequestListViewController.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit


class APIRequestListViewController : UIViewController {
    
    
    var requestResponse : [APIRequest] = []
    let requestListTableView = UITableView()
    let requestViewModel = APIRequestListViewModel()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainActivityIndicator()
        navigationController?.navigationBar.isTranslucent = false
        self.title = ThemeConstants.TABLE_VIEW_TITLE
        self.navigationController?.navigationBar.backgroundColor = .gray
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        requestViewModel.APIRequestView = self
        requestViewModel.viewDidLoad()
    }
    
    func setupMainActivityIndicator(){
        activityIndicator.color = ThemeConstants.PRIMARY_COLOR
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints({
            make in
            make.top.bottom.trailing.leading.equalToSuperview()
        })
    }
    
}
extension APIRequestListViewController: CommonViewLoadModel{
    func showLoader(_ show: Bool) {
        if(show){
            activityIndicator.startAnimating()
            print("showing loader ")
        }else{
            activityIndicator.stopAnimating()
            print("indicator stopping")
        }
    }
    
    func showError() {
        print("Error had occured from file APIRequestListViewController")
    }
    
    func showData(_ data: Any) {
        guard let Listdata = data as? [APIRequest] else {
            return
        }
        print("user table data showing")
        requestResponse = Listdata
        print(Listdata.count)
        requestListTableView.reloadData()
    }
    
    func TableViewSetUp() {
        requestListTableView.dataSource = self
        requestListTableView.delegate = self
        requestListTableView.register(APIRequestListTableView.self, forCellReuseIdentifier: "APIRequestListTableView")
        requestListTableView.register(LoaderTableViewCell.self, forCellReuseIdentifier: "LoaderTableViewCell")
        requestListTableView.separatorStyle = .none
        requestListTableView.backgroundColor = ThemeConstants.PRIMARY_BG_COLOR
        requestListTableView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        view.addSubview(requestListTableView)
        requestListTableView.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
}
extension APIRequestListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestResponse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row < requestResponse.count){
            let cell = requestListTableView.dequeueReusableCell(withIdentifier: "APIRequestListTableView", for: indexPath) as! APIRequestListTableView
            let item = requestResponse[indexPath.row]
            cell.setData(item: item)
            return cell
        }else{
            let cell = requestListTableView.dequeueReusableCell(withIdentifier: "LoaderTableViewCell", for: indexPath) as!
            LoaderTableViewCell
            cell.showLoader(true)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected \(indexPath.row)")
        if let user = requestResponse[indexPath.row].user {
            self.navigationController?.pushViewController(UserDetailsViewController(user: user), animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("\(requestResponse.count) : \(indexPath.row)")
        if requestResponse.count == indexPath.row + 2 {
            requestViewModel.APIRequestListViewModelreachedBottom()
        }
    }
    
    
}
