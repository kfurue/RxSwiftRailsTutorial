//
//  UITableViewCellExtension.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/21.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
