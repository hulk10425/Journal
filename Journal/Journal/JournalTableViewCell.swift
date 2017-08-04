//
//  JournalTableViewCell.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {

    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var journalImage: UIImageView!
    @IBOutlet weak var journalTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
