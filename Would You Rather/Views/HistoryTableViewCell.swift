//
//  HistoryTableViewCell.swift
//  Would You Rather
//
//  Created by Andre on 5/23/18.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var scenerio1Image: UIImageView!
    @IBOutlet weak var scenerio1Label: UILabel!
    @IBOutlet weak var scenerio2Image: UIImageView!
    @IBOutlet weak var scenerio2Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setCell(_ duel: Duel?, index _: Int) {

        scenerio1Label.text = duel?.question1.scene
        scenerio2Label.text = duel?.question2.scene

        if duel?.isQ1Selected == true {
            scenerio1Image.image = UIImage(named: "Green-Check-Mark")
            scenerio2Image.image = UIImage(named: "red x")
        } else {
            scenerio2Image.image = UIImage(named: "Green-Check-Mark")
            scenerio1Image.image = UIImage(named: "red x")
        }
    }
}
