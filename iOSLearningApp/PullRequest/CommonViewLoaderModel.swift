//
//  CommonViewLoaderModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
// MARK: 1. space ->DONE
protocol CommonViewLoadModel: AnyObject {
    func showLoader(_ show: Bool)
    func showError()
    func showData(_ show: Any)
    func tableViewSetUp()    
}
