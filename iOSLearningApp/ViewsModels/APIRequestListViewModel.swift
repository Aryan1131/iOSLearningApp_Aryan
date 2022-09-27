//
//  APIRequestListViewModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation
import UIKit

class APIRequestListViewModel{
    var APIRequestView: (CommonViewLoadModel)?
    var APIRequestResponse: [APIRequest] = []
    var PageNumber = 1
    
    func APIRequestListViewModelviewDidLoad(){
        APIRequestView?.showLoader(true)
        NetworkManager.shared.fetchData(APIPullRequest(PageNumber: PageNumber), completionHandler: {
            (apiRequestData: [APIRequest]) in
            self.APIRequestResponse += apiRequestData
            self.APIRequestView?.showLoader(false)
            print(" inside APIRequestListViewModel func APIRequestListViewModelviewDidLoad")
            if(self.PageNumber == 1) {
                self.APIRequestView?.TableViewSetUp()
            }
            self.APIRequestView?.showData(self.APIRequestResponse)
            self.PageNumber += 1
            
        })
        
    }
    
    func APIRequestListViewModelreachedBottom(){
        NetworkManager.shared.fetchData(APIPullRequest(PageNumber: PageNumber), completionHandler: {
            (apiRequestData: [APIRequest]) in
            self.APIRequestResponse += apiRequestData
            print(self.APIRequestResponse.count)
            self.APIRequestView?.showData(self.APIRequestResponse)
            self.PageNumber += 1
            
        })
    }
    
    
}

