//
//  APIRequestListTableView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit

class APIRequestListTableView : UITableViewCell{
    private let usersListtitleLabel = UILabel()
    private let usersListsubtitleLabel = UILabel()
    let usersListprofileImageView = UIImageView()
    private let usersListcontentLabel = UILabel()
    private let usersListcontainerView = UIView()
    let userFavButton = UIButton()
    
    var userId: String = ""
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.UserListConfigure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func UserListConfigure(){
        self.backgroundColor = .white
        userFavButton.addTarget(self, action: #selector(markUserFavButton), for:  .touchUpInside)
        SetUpusersListcontainerView()
        SetUpusersListprofileImageView()
        
        SetUpusersListtitleLabel()
        SetUpusersListsubtitleLabel()
        SetUpusersListcontentLabel()
        FavButton()
        
    }
    
    func setData(item: APIRequest) {
        usersListprofileImageView.image = UIImage(named: "user")
        if let imageUrl = item.user?.avatar_url {
            NetworkManager.shared.fetchImage(urlString: imageUrl, completionHandler: {
                img in
                self.usersListprofileImageView.image = img
            })
        }
        usersListtitleLabel.text = item.user?.login
        usersListsubtitleLabel.text = item.title
        usersListcontentLabel.text = item.body
        
        
        let network = NetworkManager()
        userId = item.user?.login ?? ""
        
        if UserDefaults.standard.object(forKey: Favourites.shared.getKeyForFavourite(userdId: userId)) == nil{
            userFavButton.setImage(UIImage(systemName: buttonSymbols.unfav), for: UIControl.State.normal)
            userFavButton.addTarget(self, action: #selector(markUserFavButton), for: .touchUpInside)
        }else{
            userFavButton.setImage(UIImage(systemName: buttonSymbols.star), for:    UIControl.State.normal)
            userFavButton.addTarget(self, action: #selector(unMarkUserFavButton), for: .touchUpInside)
        }
        
    }
    
}

private extension APIRequestListTableView{
    
    func SetUpusersListcontainerView(){
        self.contentView.addSubview(usersListcontainerView)
        usersListcontainerView.backgroundColor = .white
        usersListcontainerView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        usersListcontainerView.layer.borderWidth = 1
        usersListcontainerView.snp.makeConstraints({
            make in
            make.top.bottom.trailing.leading.equalToSuperview().inset(ThemeConstants.MARGIN)
        })
    }
    
    func SetUpusersListprofileImageView(){
        usersListcontainerView.addSubview(usersListprofileImageView)
        usersListprofileImageView.layer.cornerRadius = ThemeConstants.IMAGE_WIDTH/2
        usersListprofileImageView.clipsToBounds = true
        usersListprofileImageView.snp.makeConstraints({
            make in
            make.leading.equalToSuperview().offset(ThemeConstants.MARGIN)
            make.width.height.equalTo(ThemeConstants.IMAGE_WIDTH)
            make.centerY.equalToSuperview()
            make.bottomMargin.lessThanOrEqualToSuperview().offset(-1*ThemeConstants.MARGIN)
            make.bottom.lessThanOrEqualToSuperview().priority(.required)
        })
    }
    func FavButton(){
        usersListcontainerView.addSubview(userFavButton)
        userFavButton.setImage(UIImage(systemName: "star"), for: .normal)
        userFavButton.snp.makeConstraints({
            make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-1*ThemeConstants.MARGIN)
        })
        //userFavButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        usersListsubtitleLabel.snp.makeConstraints({
                    make in
                    make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
                    make.trailing.equalTo(userFavButton.snp.leading)
                    make.top.equalTo(usersListtitleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
                })
    }
    
    func SetUpusersListtitleLabel(){
        usersListcontainerView.addSubview(usersListtitleLabel)
        usersListcontainerView.backgroundColor = .white
        usersListtitleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.trailing.lessThanOrEqualToSuperview().offset(-1*ThemeConstants.MARGIN)
            make.top.equalToSuperview().offset(ThemeConstants.MARGIN)
        })
    }
    
    func SetUpusersListsubtitleLabel(){
        usersListcontainerView.addSubview(usersListsubtitleLabel)
        usersListsubtitleLabel.font = UIFont.systemFont(ofSize: ThemeConstants.SUBTITLE_FONT_SIZE)
        usersListsubtitleLabel.numberOfLines = 0
        usersListsubtitleLabel.textColor = .blue
//        usersListsubtitleLabel.snp.makeConstraints({
//            make in
//            make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
//            make.trailing.equalTo(userFavButton.snp.leading)
//            make.top.equalTo(usersListtitleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
//        })
    }
    // user top label
    func SetUpusersListcontentLabel(){
        usersListcontainerView.addSubview(usersListcontentLabel)
        usersListcontentLabel.font = UIFont.systemFont(ofSize: ThemeConstants.PRIMARY_FONT_SIZE)
        usersListtitleLabel.textColor = .black
        usersListcontentLabel.numberOfLines = 0
        //usersListcontentLabel.layer.borderWidth = 1
        usersListcontentLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.top.equalTo(usersListsubtitleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
            make.trailing.equalToSuperview().offset(-1*ThemeConstants.MARGIN)
            make.height.greaterThanOrEqualTo(-1*ThemeConstants.MARGIN)
            make.bottom.equalToSuperview().priority(.low)
        })
    }
    
    @objc func markUserFavButton(){
        print("list cell button clicked")
        UserDefaults.standard.set("", forKey: Favourites.shared.getKeyForFavourite(userdId: userId))
        //toggle image
        
        NotificationCenter.default.post(name: NSNotification.Name("observer"), object: nil)
        
    }
    
    @objc func unMarkUserFavButton(){
        NotificationCenter.default.post(name: NSNotification.Name("observer"), object: nil)
        UserDefaults.standard.removeObject(forKey: Favourites.shared.getKeyForFavourite(userdId: userId))
    }
    
}
