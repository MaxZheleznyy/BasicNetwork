//
//  ViewController.swift
//  BasicNetwork
//
//  Created by MAXIM ZHELEZNYY on 01.03.2022.
//

import UIKit

class ViewController: UIViewController {

    //TODO: - Move to respectful layer and inject as dependency
    private let networkService: NetworkServiceProtocol = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()

        networkService.request(
            endpoint: GithubEndpoint.getUserDetails(userName: "defunkt")
        ) { (result: Result<GithubUserModel, Error>) in
            redispatchToMainThread {
                switch result {
                case .success(let response):
                    //TODO: - Work with response
                    print("Response: ", response)
                case .failure(let error):
                    //TODO: - Handle error
                    print(error)
                }
            }
        }
    }
}

