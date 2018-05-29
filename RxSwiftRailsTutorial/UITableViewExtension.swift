//
//  UITableViewExtension.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/22.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellType: T.Type) where T: Nibable {
        register(T.nib, forCellReuseIdentifier: T.identifier)
    }

    func register<T: UITableViewCell>(_ cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(with cellType: T.Type,
                                                 for indexPath: IndexPath) -> T {
        // swiftlint:disable force_cast
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
        // swiftlint:enable force_cast
    }
}
