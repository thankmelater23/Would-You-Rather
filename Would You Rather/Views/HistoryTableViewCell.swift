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
  
   func setCell(_ duel: Duel?, index: Int) {
    
    self.scenerio1Label.text = duel?.question1.scene
    self.scenerio2Label.text = duel?.question2.scene
    
    if duel?.isQ1Selected == true{
      self.scenerio1Image.image = UIImage.init(named: "Green-Check-Mark")
      self.scenerio2Image.image = UIImage.init(named: "red x")
    }else{
      self.scenerio2Image.image = UIImage.init(named: "Green-Check-Mark")
      self.scenerio1Image.image = UIImage.init(named: "red x")
    }
  }
  
}
