//
//  MicropostCellTableViewCell.swift
//  RxSwiftRailsTutorial
//
//  Created by Kazuhiro Furue on 2018/05/22.
//  Copyright © 2018年 Kazuhiro Furue. All rights reserved.
//

import UIKit

class MicropostTableViewCell: UITableViewCell, Nibable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(micropost: Micropost) {
        textLabel?.text? = micropost.content
        detailTextLabel?.text? = String(micropost.userId)
    }

}
