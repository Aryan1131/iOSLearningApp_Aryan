//
//  LoaderTableView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit
import SnapKit

class LoaderTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureLoaderTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    private func configureLoaderTableViewCell () {
        self.backgroundColor = .lightGray
        activityIndicatorView.color = ThemeConstants.PRIMARY_COLOR
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(ThemeConstants.MARGIN)
        })
    }
    
    func showLoader(_ show: Bool) {
        if(show == true) {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}

