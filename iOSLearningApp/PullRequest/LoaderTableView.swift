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
    
    private var activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureLoaderTableViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError(errorConstants.fatalerror)
    }
    
    private func configureLoaderTableViewCell () {
        self.backgroundColor = .darkGray
        activityIndicatorView.color = ThemeConstants.PRIMARY_BG_COLOR
        self.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints({
            make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(ThemeConstants.MARGIN)
        })
    }
    
    func showLoader(_ show: Bool) {
        // MARK: 18 paranthesis not required ->ASK Showing error
        if show == true {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}

