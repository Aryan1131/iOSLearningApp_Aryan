//
//  ProfileImageView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit
import AYNetworkManager

class profileImageTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError(errorConstants.fatalerror)
    }
    
    private let profileImageView = UIImageView()


    func configure() {
        self.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = ThemeConstants.IMAGE_WIDTH/2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .blue
        self.contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints({
            make in
            make.height.width.equalTo(ThemeConstants.IMAGE_WIDTH)
            make.centerX.centerY.equalToSuperview()
        })
        
    }
    

    func setData(imageUrl: String) {
        // MARK: 37 string in code ->Done
        profileImageView.image = UIImage(named: userDetailConstants.USER)
        NetworkManager.shared.fetchImage(urlString: imageUrl, completionHandler: {
            img in
            self.profileImageView.image = img
        })
    }
    
}
