//
//  ViewController.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/02.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import OAuthSwift
import KeychainAccess

class ViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var feedTableView: UITableView!

    fileprivate let viewModel = FeedViewModel()
    private let disposeBag = DisposeBag()
    let oauthswift = OAuth2Swift(
        consumerKey: "15afda6f72009b78571150d63f57bc690a436c8e1199c09bc2de05bc63c09f14",
        consumerSecret: "e590044244da414ece872de0ada52aed33d1cf889d365cb3da4dceed710668b8",
        authorizeUrl: "https://fierce-wave-40771.herokuapp.com/oauth/authorize",
        accessTokenUrl: "https://fierce-wave-40771.herokuapp.com/oauth/token",
        responseType: "code"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        viewModel.fetchFeeds()
    }

    override func viewDidAppear(_ animated: Bool) {
        let keychain = Keychain(service: "kfurue.RxSwiftRailsTutorial-token")

        if keychain["oauthToken"] == nil {
            oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
            oauthswift.authorize(
                withCallbackURL: URL(string: "sample-app://oauth-callback")!,
                scope: "", state: "hoge",
                success: { credential, _, _ in
                    print(credential.oauthToken)
                    keychain["oauthToken"] = credential.oauthToken
            },
                failure: { error in
                    print(error.localizedDescription)
            }
            )
        }

    }

    private func configureObserver() {
        let keychain = Keychain(service: "kfurue.RxSwiftRailsTutorial-token")

        guard let token = (try? keychain.get("oauthToken")) as? String else {
            return
        }

        SampleAppClientAPI.customHeaders["Authorization"]
            = "Bearer " + token
        feedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        viewModel.feeds.asDriver().drive(
            feedTableView.rx.items(cellIdentifier: "Cell"),
            curriedArgument: {_, micropost, cell in
                cell.textLabel?.text = micropost.content
        }).disposed(by: disposeBag)
    }

}
