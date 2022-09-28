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
    
    
    var SaveProfileButton = UIBarButtonItem()
    var FavrouiteProfileButton = UIBarButtonItem()
    
    var details : User?
    var userId = ""
    //let UserViewModel =  UserDetailsViewModel()
    
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
        //        if(UserDefaults.standard.object(forKey: userDetails?.login)==nil){
        //
        //        }
        setupMainActivityIndicatorView()
        userDetailsViewModel.userDetailsViewModelDelegate = self
        guard let userDetails = userDetails else {
            return
        }
        userDetailsViewModel.viewDidLoad(user: userDetails)
        //        if(SaveProfileButton.image != UIImage(systemName: "bookmark.fill")){
        //        SaveProfileButton.target = self
        //        SaveProfileButton.action = #selector(clicktoSave)
        //        SaveProfileButton.image = UIImage(systemName: "bookmark")
        //        }else{
        //            SaveProfileButton.image = UIImage(systemName: "bookmark.fill")
        //        }
        //        FavrouiteProfileButton.target = self
        //        FavrouiteProfileButton.action = #selector(clickToAddToFavrouite)
        //        FavrouiteProfileButton.image = UIImage(systemName: "star" )
        /*
         if UserDefaults.standard.object(forKey: "favourite\(String(describing: u_login))")==nil{
         FavouriteButton.image = UIImage(systemName: "star")
         }
         else{
         FavouriteButton.image = UIImage(systemName: "star.fill")
         }
         if UserDefaults.standard.object(forKey: u_login ?? "")==nil{
         DownloadButton.image = UIImage(systemName: "square.and.arrow.down")
         }
         else{
         DownloadButton.image = UIImage(systemName: "delete.forward.fill")
         }
         */
        
        if UserDefaults.standard.object(forKey: "favProfile\(String(describing: userId))") == nil{
            FavrouiteProfileButton.image = UIImage(systemName: "star")
        }else{
            FavrouiteProfileButton.image = UIImage(systemName: "star.fill")
        }
        
        if UserDefaults.standard.object(forKey: userId ?? "") == nil{
            SaveProfileButton.image = UIImage(systemName: "bookmark")
        }else{
            SaveProfileButton.image = UIImage(systemName: "bookmark.fill")
        }
        navigationItem.rightBarButtonItems = [SaveProfileButton,FavrouiteProfileButton]
    }
    func setupMainActivityIndicatorView(){
        view.addSubview(mainActivityIndicator)
        mainActivityIndicator.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    @objc func clicktoSave(){
        do{
            let encodeData = try JSONEncoder().encode(userDetails)
            guard let jsonString = String(data: encodeData,encoding: .utf8)else{
                return
            }
        }catch{
            print("Failed to encode")
        }
    }
    
    @objc func clickToAddToFavrouite(){
        print("inside clickToAddToFavrouite function \(userDetails?.login)")
        if(FavrouiteProfileButton.image == UIImage(systemName: "star.fill" )){
            FavrouiteProfileButton.image = UIImage(systemName: "star" )
        }else{
            FavrouiteProfileButton.image = UIImage(systemName: "star.fill" )
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
        //self.navigationItem.rightBarButtonItems = [FavrouiteProfileButton,SaveProfileButton]
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
    
    func profileSave(){
        SaveProfileButton.style = .plain
        SaveProfileButton.target = self
        SaveProfileButton.image = UIImage(systemName: "bookmark")
        SaveProfileButton.action = #selector(clicktoSave)
    }
    
}

extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDetailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row != 0) {
            let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell", for: indexPath) as! UserDetailsViewCell
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

extension UserDetailsViewController{
    
    func bookmarkUserBotton(){
        SaveProfileButton.style = .plain
        SaveProfileButton.target = self
        SaveProfileButton.action = #selector(bookmarkUserBottonAction)
    }
   
    func unBookmarkUserBotton(){
        SaveProfileButton.style = .plain
        SaveProfileButton.target = self
        SaveProfileButton.action = #selector(unBookmarkUserBottonAction)
    }
    func favouriteUserBotton(){
        FavrouiteProfileButton.style = .plain
        FavrouiteProfileButton.target = self
        FavrouiteProfileButton.action = #selector(favouriteUserBottonAction)
    }
    
    @objc func bookmarkUserBottonAction(){
        guard let encodedData = try? JSONEncoder().encode(details) else {
            return
        }
        guard let JSONString = String(data: encodedData, encoding: .utf8) else{
            return
        }
        if UserDefaults.standard.object(forKey: userId) == nil{
            UserDefaults.standard.set(JSONString, forKey: userId)
            SaveProfileButton.image = UIImage(systemName: "bookmark.fill")
            let alertMessage = UIAlertController(title: "Bookmark`", message: "Profile Bookmarked", preferredStyle: .alert)
            self.present(alertMessage, animated: true, completion: nil)
            
            let when = DispatchTime.now() + 2
            DispatchQueue.main.asyncAfter(deadline: when) {
                alertMessage.dismiss(animated: true ,completion: nil)
            }
        }else{
            print("want to unbookmark the user")
            unBookmarkUserBottonAction()
        }
    }
    
    @objc func unBookmarkUserBottonAction(){
        if UserDefaults.standard.objectIsForced(forKey: userId) == nil{
            return
        }else{
            let alertMessage = UIAlertController(title: "Bookmarked", message: "Want to bookaark this user", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                UserDefaults.standard.removeObject(forKey: self.userId)
                self.SaveProfileButton.image = UIImage(systemName: "bookmark")
                let alterMsg = UIAlertController(title: "Un Bookmarked", message: "User profile has been removed from bookmarked", preferredStyle: .alert)
                self.present(alertMessage, animated: true, completion: nil)
                
                let when = DispatchTime.now()
                DispatchQueue.main.asyncAfter(deadline: when){
                    alertMessage.dismiss(animated: true,completion: nil)
                }
            })
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel){
                (action) -> Void in
                return
            }
            alertMessage.addAction(okButton)
            alertMessage.addAction(cancelButton)
            self.present(alertMessage, animated: true, completion: nil)
        }
    }
    @objc func favouriteUserBottonAction(){
        let data: String = ""
        if UserDefaults.standard.object(forKey: "favProfile\(userId)") == nil{
            UserDefaults.standard.set(data, forKey: "favProfile\(userId)")
            FavrouiteProfileButton.image = UIImage(systemName: "star.fill")
        }else{
            UserDefaults.standard.removeObject(forKey:"favProfile\(userId)")
            FavrouiteProfileButton.image = UIImage(systemName: "star")
        }
        NotificationCenter.default.post(name: NSNotification.Name("observer"), object: nil)
    }
    
}
