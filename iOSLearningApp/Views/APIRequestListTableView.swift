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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.UserListConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let usersListtitleLabel = UILabel()
    private let usersListsubtitleLabel = UILabel()
    private let usersListprofileImageView = UIImageView()
    private let usersListcontentLabel = UILabel()
    private let usersListcontainerView = UIView()
    
    func UserListConfigure(){
        self.backgroundColor = .gray
        SetUpusersListcontainerView()
        SetUpusersListprofileImageView()
        SetUpusersListtitleLabel()
        SetUpusersListsubtitleLabel()
        SetUpusersListcontentLabel()
        
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
    }
    
}

private extension APIRequestListTableView{
    
    func SetUpusersListcontainerView(){
        self.addSubview(usersListcontainerView)
        usersListcontainerView.backgroundColor = ThemeConstants.PRIMARY_COLOR
        usersListcontainerView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        usersListcontainerView.snp.makeConstraints({
            make in
            make.top.bottom.trailing.leading.equalToSuperview().inset(ThemeConstants.MARGIN)
        })
    }
    
    func SetUpusersListprofileImageView(){
        usersListcontainerView.addSubview(usersListprofileImageView)
        usersListprofileImageView.layer.cornerRadius = ThemeConstants.IMAGE_WIDTH
        usersListprofileImageView.clipsToBounds = true
        usersListprofileImageView.snp.makeConstraints({
            make in
            make.leading.equalToSuperview().offset(ThemeConstants.MARGIN)
            make.width.height.equalTo(ThemeConstants.IMAGE_WIDTH)
            make.centerY.equalToSuperview()
        })
    }
    
    
    func SetUpusersListtitleLabel(){
        usersListcontainerView.addSubview(usersListtitleLabel)
        usersListtitleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.trailing.lessThanOrEqualToSuperview().offset(ThemeConstants.MARGIN)
            make.top.equalToSuperview().offset(ThemeConstants.MARGIN)
        })
    }
    
    
    func SetUpusersListsubtitleLabel(){
        usersListcontainerView.addSubview(usersListsubtitleLabel)
        usersListsubtitleLabel.font = UIFont.systemFont(ofSize: ThemeConstants.SUBTITLE_FONT_SIZE)
        usersListsubtitleLabel.numberOfLines = 0
        usersListsubtitleLabel.textColor = .black
        usersListsubtitleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(usersListprofileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.trailing.equalToSuperview().offset(ThemeConstants.MARGIN)
            make.top.equalTo(usersListtitleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
        })
    }
    
    
    func SetUpusersListcontentLabel(){
        usersListcontainerView.addSubview(usersListcontentLabel)
        usersListcontentLabel.font = UIFont.systemFont(ofSize: ThemeConstants.MARGIN)
        usersListcontentLabel.numberOfLines = 0
        usersListcontentLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(usersListprofileImageView)
        })
    }
}
