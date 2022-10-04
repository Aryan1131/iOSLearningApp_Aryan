//
//  APIRequestListViewModel.swift
//  iOSLearningApp
//
//  Created by Aryan Yadav on 27/09/22.
//

import Foundation

class pullRequestViewCell {
    // MARK: 11  try to make everything private ->DONE
    var APIRequestView: (CommonViewLoadModel)?
    private var APIRequestResponse: [pullRequest] = []
    private var PageNumber = 1
    
    func viewDidLoad() {
        APIRequestView?.showLoader(true)
        NetworkManager.shared.fetchData(APIPullRequest(PageNumber: PageNumber), completionHandler: {
            (apiRequestData: [pullRequest]) in
            self.APIRequestResponse += apiRequestData
            self.APIRequestView?.showLoader(false)
            if(self.PageNumber == 1) {
                self.APIRequestView?.tableViewSetUp()
            }
            self.APIRequestView?.showData(self.APIRequestResponse)
            self.PageNumber += 1
        })
    }
    
    func APIRequestListViewModelReachedBottom() {
        NetworkManager.shared.fetchData(APIPullRequest(PageNumber: PageNumber), completionHandler: {
            (apiRequestData: [pullRequest]) in
            self.APIRequestResponse += apiRequestData
            print(self.APIRequestResponse.count)
            self.APIRequestView?.showData(self.APIRequestResponse)
            self.PageNumber += 1
            
        })
    }
    
    
}

