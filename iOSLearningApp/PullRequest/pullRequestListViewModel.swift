//
//  APIRequestListTableView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import AYNetworkManager
import AYUserDefaultsManager

class pullRequestListViewModel: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let profileImageView = UIImageView()
    private let contentLabel = UILabel()
    private let containerView = UIView()
    private let userFavButton = UIButton()
    
    private var userId: String = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(errorConstants.fatalerror)
    }
    
    func configure() {
        self.backgroundColor = .white
        userFavButton.addTarget(self, action: #selector(markUserFavButton), for: .touchUpInside)
        setUpUsersListContainerView()
        setUpUsersListProfileImageView()
        setUpUsersListTitleLabel()
        setUpUsersListSubTitleLabel()
        setUpUsersListContentLabel()
        favButton()
    }
    
    func setData(item: pullRequest) {
        if let imageUrl = item.user?.avatar_url {
            NetworkManager.shared.fetchImage(urlString: imageUrl, completionHandler: {
                img in
                self.profileImageView.image = img
            })
        }
        
        titleLabel.text = item.user?.login
        subtitleLabel.text = item.title
        contentLabel.text = item.body
        // MARK: 2, 3 . warning and not used shared instance ->Done
        userId = item.user?.login ?? ""

        if UserDefaults.standard.object(forKey: Favourites.shared.getKeyForFavourite(userdId: userId)) == nil {
            userFavButton.setImage(UIImage(systemName: buttonSymbols.unstar), for: UIControl.State.normal)
            userFavButton.addTarget(self, action: #selector(markUserFavButton), for: .touchUpInside)
        } else {
            userFavButton.setImage(UIImage(systemName: buttonSymbols.star), for:    UIControl.State.normal)
            userFavButton.addTarget(self, action: #selector(unMarkUserFavButton), for: .touchUpInside)
        }
    }
}

private extension pullRequestListViewModel {
    
    func setUpUsersListContainerView() {
        self.contentView.addSubview(containerView)
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = ThemeConstants.CORNER_RADIUS
        containerView.layer.borderWidth = 1
        containerView.snp.makeConstraints({
            make in
            make.top.bottom.trailing.leading.equalToSuperview().inset(ThemeConstants.MARGIN)
        })
    }
    
    func setUpUsersListProfileImageView() {
        containerView.addSubview(profileImageView)
        profileImageView.layer.cornerRadius = ThemeConstants.IMAGE_WIDTH/2
        profileImageView.clipsToBounds = true
        profileImageView.snp.makeConstraints({
            make in
            make.leading.equalToSuperview().offset(ThemeConstants.MARGIN)
            make.width.height.equalTo(ThemeConstants.IMAGE_WIDTH)
            make.centerY.equalToSuperview()
            make.bottomMargin.lessThanOrEqualToSuperview().offset(-1*ThemeConstants.MARGIN)
            make.bottom.lessThanOrEqualToSuperview().priority(.required)
        })
    }
    
    func favButton() {
        containerView.addSubview(userFavButton)
        userFavButton.setImage(UIImage(systemName: buttonSymbols.unstar), for: .normal)
        userFavButton.snp.makeConstraints({
            make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-1*ThemeConstants.MARGIN)
        })
        
        subtitleLabel.snp.makeConstraints({
                    make in
                    make.leading.equalTo(profileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
                    make.trailing.equalTo(userFavButton.snp.leading)
                    make.top.equalTo(titleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
                })
    }
    
    func setUpUsersListTitleLabel() {
        containerView.addSubview(titleLabel)
        containerView.backgroundColor = .white
        titleLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.trailing.lessThanOrEqualToSuperview().offset(-1*ThemeConstants.MARGIN)
            make.top.equalToSuperview().offset(ThemeConstants.MARGIN)
        })
    }
    
    func setUpUsersListSubTitleLabel() {
        containerView.addSubview(subtitleLabel)
        subtitleLabel.font = UIFont.systemFont(ofSize: ThemeConstants.SUBTITLE_FONT_SIZE)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textColor = .blue
    }
    
    func setUpUsersListContentLabel() {
        containerView.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFont(ofSize: ThemeConstants.PRIMARY_FONT_SIZE)
        titleLabel.textColor = .black
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints({
            make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(ThemeConstants.MARGIN)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(ThemeConstants.MARGIN)
            // MARK: 8 use space between * symbols ->DONE
            make.trailing.equalToSuperview().offset(-1 * ThemeConstants.MARGIN)
            make.height.greaterThanOrEqualTo(-1 * ThemeConstants.MARGIN)
            make.bottom.equalToSuperview().priority(.low)
        })
    }
    // MARK: 9  objc should be in seperate line ->DONE
    @objc
    func markUserFavButton() {
        //UserDefaults.standard.set("", forKey: Favourites.shared.getKeyForFavourite(userdId: userId))
        UserDefaultsManager.shared.saveData(Value: "",
                                            Key: Favourites.shared.getKeyForFavourite(userdId: userId))
        NotificationCenter.default.post(name: NSNotification.Name(notificationConstants.Observer), object: nil)
    }
    
    // MARK: 10  objc should be in seperate line ->DONE
    @objc
    func unMarkUserFavButton() {
        NotificationCenter.default.post(name: NSNotification.Name(notificationConstants.Observer), object: nil)
        //UserDefaults.standard.removeObject(forKey: Favourites.shared.getKeyForFavourite(userdId: userId))
        UserDefaultsManager.shared.deletedata(Key: Favourites.shared.getKeyForFavourite(userdId: userId))
    }
}
