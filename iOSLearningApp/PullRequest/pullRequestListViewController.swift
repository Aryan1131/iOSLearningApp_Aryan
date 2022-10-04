//
//  APIRequestListViewController.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit

class pullRequestListViewController : UIViewController {
    
    private var requestResponse: [pullRequest] = []
    private let requestListTableView = UITableView()
    private let requestViewModel = pullRequestViewCell()
    private let userFavButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    private var userId: String = ""
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // MARK: 12  string in code ->DONE
        fatalError(errorConstants.fatalerror)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainActivityIndicator()
        navigationController?.navigationBar.isTranslucent = false
        self.title = ThemeConstants.TABLE_VIEW_TITLE
        self.navigationController?.navigationBar.backgroundColor = .gray
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        requestViewModel.APIRequestView = self
        requestViewModel.viewDidLoad()
        let reloadTable: (Notification) -> Void = { make in
            self.requestListTableView.reloadData()
        }
        // MARK: 13  long line ->DONE
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name(notificationConstants.Observer),
            object: nil, queue: nil, using: reloadTable)
    }
    
    func setupMainActivityIndicator() {
        activityIndicator.color = ThemeConstants.SECONDARY_COLOR
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints({
            make in
            make.top.bottom.trailing.leading.equalToSuperview()
        })
    }
}

// MARK: CommonViewLoadModelDelegate methods

extension pullRequestListViewController: CommonViewLoadModel {
    func showLoader(_ show: Bool) {
        // MARK: 14  paranthesis not required for if
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showError() {
        // MARK: 15  print statement ->DONE
        print(errorConstants.error)
    }
    
    func showData(_ data: Any) {
        guard let Listdata = data as? [pullRequest] else {
            return
        }
        requestResponse = Listdata
        print(Listdata.count)
        requestListTableView.reloadData()
    }
    
    func tableViewSetUp() {
        requestListTableView.dataSource = self
        requestListTableView.delegate = self
        requestListTableView.register(pullRequestListViewModel.self, forCellReuseIdentifier: pullRequestListViewModel.description())
        requestListTableView.register(LoaderTableViewCell.self, forCellReuseIdentifier: LoaderViewCell.description())
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

// MARK: UITableViewDataSource methods

// MARK: 16  space required before { ->DONE
extension pullRequestListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestResponse.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < requestResponse.count,
           let cell = requestListTableView.dequeueReusableCell(withIdentifier: pullRequestListViewModel.description(), for: indexPath) as? pullRequestListViewModel {
            let item = requestResponse[indexPath.row]
            cell.setData(item: item)
            return cell
        } else {
            let cell = requestListTableView.dequeueReusableCell(withIdentifier: LoaderViewCell.description(), for: indexPath) as! LoaderTableViewCell
            cell.showLoader(true)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = requestResponse[indexPath.row].user {
            self.navigationController?.pushViewController(userDetailsViewModels(user: user), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // MARK: 17  print statement ->DONE
        print("\(requestResponse.count) : \(indexPath.row)")
        if requestResponse.count == indexPath.row + 2 {
            requestViewModel.APIRequestListViewModelReachedBottom()
        }
    }
}

extension Notification.Name {
    enum Generic: String {
        case observer
    }
}
