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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObserver()
        viewModel.fetchFeeds()
    }

    private func configureObserver() {
        SampleAppClientAPI.customHeaders["Authorization"]
            = "Bearer 5c1391cdfee16ffe5e380b41ce3e58dbbf30bc16a597542ac0289f4f936a6d91"
        feedTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        viewModel.feeds.asDriver().drive(
            feedTableView.rx.items(cellIdentifier: "Cell"),
            curriedArgument: {_, micropost, cell in
                cell.textLabel?.text = micropost.content
        }).disposed(by: disposeBag)
    }

}
