//
//  LoadingScreenView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 29/09/22.
//
// MARK: 38 no space after import ->DONE
import Foundation
import UIKit
import SnapKit

class LoaderViewCell: UITableViewCell {
    private let spinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    private let loadingLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    required init?(coder: NSCoder) {
        // MARK: 49 string in code
        fatalError(errorConstants.fatalerror)
    }
    // MARK: 39 there was no space here, between functions
    func configure(){
        self.contentView.addSubview(loadingView)
        loadingView.snp.makeConstraints{ make in
            make.top.bottom.left.right.equalToSuperview().offset(ThemeConstants.SUBTITLE_FONT_SIZE / 2)
        }
        loadingView.addSubview(loadingLabel)
    }
    // MARK: 40 there was no space here, between functions ->DONE
    func showLoader() {
        loadingView.backgroundColor = .white
        spinner.color = .blue
        spinner.transform = CGAffineTransform(scaleX: CGFloat(ThemeConstants.SPINNER_DIAMETER), y: CGFloat(ThemeConstants.SPINNER_DIAMETER))
        loadingView.backgroundColor = .white
        loadingView.snp.makeConstraints{make in
            make.centerX.centerY.equalToSuperview()
        }
        loadingView.addSubview(spinner)
        spinner.snp.makeConstraints{make in
            // MARK: 50 numbers in code
            make.top.bottom.equalToSuperview().offset(ThemeConstants.SUBTITLE_FONT_SIZE)
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        spinner.startAnimating()
    }
}
