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

class ViewController: UIViewController {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIconImageView: UIImageView!
    @IBOutlet weak var feedTableView: UITableView!

    fileprivate let viewModel = FeedViewModel()
    private let disposeBag = DisposeBag()
    private let oauthRailsTutorial = OauthRailsTutorial()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
    }

    override func viewDidAppear(_ animated: Bool) {
        oauthRailsTutorial
            .token {[unowned self] (token, _) in
                guard let token = token else {
                    return
                }
                SampleAppClientAPI.customHeaders["Authorization"]
                    = "Bearer " + token
                self.viewModel.fetchFeeds()
        }
    }

    private func configureObserver() {
        feedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        viewModel.feeds.asDriver().drive(
            feedTableView.rx.items(cellIdentifier: "Cell"),
            curriedArgument: {_, micropost, cell in
                cell.textLabel?.text = micropost.content
        }).disposed(by: disposeBag)
    }

}
