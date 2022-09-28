//
//  UserDetailsView.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 26/09/22.
//

import Foundation

import UIKit
import SnapKit

class UserDetailsViewCell : UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUserDetailsViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let keyLabel = UILabel()
    let valueLabel = UILabel()
    
    func configureUserDetailsViewCell() {
        self.backgroundColor = .white
        setupKeyLabel()
        setupValueLabel()
    }
    func setDataUserDetailsViewCell(key: String, value: String){
        keyLabel.text = key
        valueLabel.text = value
    }
}

private extension UserDetailsViewCell{
    func setupKeyLabel(){
        self.contentView.addSubview(keyLabel)
        keyLabel.backgroundColor = .white
        keyLabel.snp.makeConstraints({
            make in
            make.top.bottom.equalToSuperview().inset(ThemeConstants.MARGIN/2)
            make.leading.equalToSuperview().inset(ThemeConstants.MARGIN)
            make.trailing.equalToSuperview().inset(-1*ThemeConstants.MARGIN)
        })
    }
    
    func setupValueLabel(){
        self.contentView.addSubview(valueLabel)
        valueLabel.snp.makeConstraints({
            make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(ThemeConstants.MARGIN)
            make.trailing.equalToSuperview().inset(-1*ThemeConstants.MARGIN)
        })
    }
}
