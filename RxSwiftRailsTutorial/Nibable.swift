//
//  Nibable.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/21.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import Foundation
import UIKit

protocol Nibable: NSObjectProtocol {
    static var nibName: String { get }
    static var nib: UINib { get }
}

extension Nibable {
    static var nibName: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
