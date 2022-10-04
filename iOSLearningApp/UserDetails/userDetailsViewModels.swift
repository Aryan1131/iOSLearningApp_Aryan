//
//  UserDetailsViewController.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit
import AYUserDefaultsManager

class userDetailsViewModels: UIViewController {
    
    private let mainActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private var userDetails: User?
    private var userDetailsList: [cellModel] = []
    private let userDetailsTableView = UITableView()
    private let userDetailsViewModel: userDetailController
    private var saveProfileButton = UIBarButtonItem()
    private var favrouiteProfileButton = UIBarButtonItem()
    // MARK: 19 space between : should be consistenct throught project ->DONE
    private var details: User?
    private var userId = ""
   
    init(user: User) {
        self.userDetailsViewModel = userDetailController()
        super.init(nibName: nil, bundle: nil)
        userDetails = user
        userId = (userDetails?.login)!
    }
    
    required init?(coder: NSCoder) {
        // MARK: 53 string in code -> DONE
        fatalError(errorConstants.fatalerror)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = userDetails?.login
        
        setupMainActivityIndicatorView()
        userDetailsViewModel.userDetailsViewModelDelegate = self
        guard let userDetails = userDetails else {
            return
        }
        
        profileSave()
        favouriteUserBotton()
        bookmarkUserBotton()
        userDetailsViewModel.viewDidLoad(user: userDetails)
        
        // MARK: 20 no space after nil ->DONE
        if UserDefaultsManager.shared.getData(Key: "favProfile\(String(describing: userId))") == nil {
            favrouiteProfileButton.image = UIImage(systemName: buttonSymbols.unstar)
        } else {
            favrouiteProfileButton.image = UIImage(systemName: buttonSymbols.star)
        }
        // MARK: 52 warnings
        if UserDefaultsManager.shared.getData(Key: userId) == nil {
            saveProfileButton.image = UIImage(systemName: buttonSymbols.unmark)
        } else {
            saveProfileButton.image = UIImage(systemName: buttonSymbols.bookmark)
        }
        navigationItem.rightBarButtonItems = [saveProfileButton,favrouiteProfileButton]
    }
    func setupMainActivityIndicatorView(){
        view.addSubview(mainActivityIndicator)
        mainActivityIndicator.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    // MARK: 24 objc annotation in seperate line ->DONE
    @objc
    private func clickToAddToFavrouite() {
        if favrouiteProfileButton.image == UIImage(systemName: buttonSymbols.star) {
            favrouiteProfileButton.image = UIImage(systemName: buttonSymbols.unstar)
        }else{
            favrouiteProfileButton.image = UIImage(systemName: buttonSymbols.star)
        }
    }
}

extension userDetailsViewModels: CommonViewLoadModel {
    
    func showData(_ data: Any) {
        guard let userData = data as? [cellModel] else {
            return
        }
        userDetailsList = userData
        print(userData.count)
        userDetailsTableView.reloadData()
    }
    
    func tableViewSetUp() {
        userDetailsTableView.dataSource = self
        userDetailsTableView.delegate = self
        userDetailsTableView.register(userDetailsViewCell.self, forCellReuseIdentifier: userDetailsViewCell.description())
        userDetailsTableView.register(profileImageTableViewCell.self, forCellReuseIdentifier: profileImageTableViewCell.description())
        userDetailsTableView.separatorStyle = .none
        userDetailsTableView.backgroundColor = ThemeConstants.SECONDARY_COLOR
        userDetailsTableView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        view.addSubview(userDetailsTableView)
        userDetailsTableView.snp.makeConstraints({
            make in
            make.top.leading.trailing.bottom.equalToSuperview()
        })
    }
    
    func showLoader(_ show: Bool) {
        // MARK: 24 objc annotation in seperate line -> ASK error showing
        if(show){
            mainActivityIndicator.startAnimating()
            // MARK: 27 there was empty line here
        }else{
            mainActivityIndicator.stopAnimating()
        }
    }
    
    func showError() {
        // MARK: 25, 26 print and string in code ->DONE
        print(errorConstants.error)
    }
    
    func profileSave() {
        saveProfileButton.style = .plain
        saveProfileButton.target = self
        saveProfileButton.image = UIImage(systemName:buttonSymbols.bookmark)
    }
}

extension userDetailsViewModels: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != 0) {
            let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: userDetailsViewCell.description(), for: indexPath) as! userDetailsViewCell
            let data: cellModel = userDetailsList[indexPath.row]
            cell.setDataUserDetailsViewCell(key: data.leftLabel, value: data.rightLabel)
            return cell
        } else {
            let cell =  userDetailsTableView.dequeueReusableCell(withIdentifier: profileImageTableViewCell.description(), for: indexPath) as! profileImageTableViewCell
            cell.setData(imageUrl: userDetails?.avatar_url ?? " ")
            return cell
        }
    }
}

extension userDetailsViewModels {
    
    func bookmarkUserBotton() {
        saveProfileButton.style = .plain
        saveProfileButton.target = self
        saveProfileButton.action = #selector(bookmarkUserBottonAction)
    }
    
    // MARK: 28 improper indentation ->DONE
    func unBookmarkUserBotton() {
        saveProfileButton.style = .plain
        saveProfileButton.target = self
        saveProfileButton.action = #selector(unBookmarkUserBottonAction)
    }
    
    func favouriteUserBotton() {
        favrouiteProfileButton.style = .plain
        favrouiteProfileButton.target = self
        favrouiteProfileButton.action = #selector(favouriteUserBottonAction)
    }
}

private extension userDetailsViewModels {
    
    // MARK: 29 objc should be in seperate line ->DONE
    @objc
    func bookmarkUserBottonAction() {
        guard let encodedData = try? JSONEncoder().encode(details) else {
            return
        }
        
        guard let JSONString = String(data: encodedData, encoding: .utf8) else{
            return
        }
        if UserDefaultsManager.shared.getData(Key: userId) == nil {
            UserDefaultsManager.shared.saveData(Value: JSONString, Key: userId)
            saveProfileButton.image = UIImage(systemName: buttonSymbols.bookmark)
            // MARK: 30 string in code
            let alertMessage = UIAlertController(title: alertConstants.bookmarkTitle,
                                                 message: alertConstants.bookmarkAlertTitle,
                                                 preferredStyle: .alert)
            self.present(alertMessage, animated: true, completion: nil)
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                alertMessage.dismiss(animated: true ,completion: nil)
            }
        } else {
            unBookmarkUserBottonAction()
        }
    }
    // MARK: 51 objc in seperate line ->DONE
    @objc
    func unBookmarkUserBottonAction() {
        if UserDefaultsManager.shared.getData(Key: userId) == nil {
            return
        } else {
            // MARK: 31 string in code
            let alertMessage = UIAlertController(title: alertConstants.bookmarkAlertTitle,
                                                 message: alertConstants.bookmarkAlertMessage,
                                                 preferredStyle: .alert)
            let okButton = UIAlertAction(title: alertConstants.ok, style: .default, handler: { (action) -> Void in
                UserDefaults.standard.removeObject(forKey: self.userId)
                self.saveProfileButton.image = UIImage(systemName: buttonSymbols.bookmark)
                // MARK: 32 string in code
                let alterMsg = UIAlertController(title: alertConstants.unMarkAlertTitle,
                                                 message: alertConstants.unMarkAltertMessage,
                                                 preferredStyle: .alert)
                self.present(alterMsg, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                    alterMsg.dismiss(animated: true,completion: nil)
                }
            })
            
            let cancelButton = UIAlertAction(title: alertConstants.cancel , style: .cancel){
                (action) -> Void in
                return
            }
            
            alertMessage.addAction(okButton)
            alertMessage.addAction(cancelButton)
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    
    // MARK: 33 objc in seperate line ->DONE
    @objc
    func favouriteUserBottonAction() {
        let data: String = ""
        // MARK: 34 string in code
        if UserDefaultsManager.shared.getData(Key: "favProfile\(userId)") == nil {
            UserDefaultsManager.shared.saveData(Value: data, Key: "favProfile\(userId)")
            favrouiteProfileButton.image = UIImage(systemName:buttonSymbols.star)
        } else {
            UserDefaults.standard.removeObject(forKey:"favProfile\(userId)")
            favrouiteProfileButton.image = UIImage(systemName:buttonSymbols.unstar)
        }
        NotificationCenter.default.post(name: NSNotification.Name(notificationConstants.Observer), object: nil)
    }
}

extension UIImage {
    
    enum Assets: String {
        case save
        
        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
}
