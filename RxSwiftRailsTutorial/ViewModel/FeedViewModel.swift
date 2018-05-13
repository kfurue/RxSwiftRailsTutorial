//
//  FeedViewModel.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/06.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import Foundation
import RxSwift

final class FeedViewModel {
    let feeds: Variable<[Micropost]> = Variable([Micropost]())
    private var disposeBag = DisposeBag()

    func fetchUsers() {
        disposeBag = DisposeBag()
        FeedAPI.getApiV1Feed().subscribe(onNext: { [unowned self] feeds in
            self.feeds.value += feeds
        })
        .disposed(by: disposeBag)
    }
}
