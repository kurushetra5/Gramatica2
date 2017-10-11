//
//  RankTypeTableViewCell.swift
//  Gramatica
//
//  Created by Kurushetra on 8/10/17.
//  Copyright © 2017 Kurushetra. All rights reserved.
//

import UIKit

class RankTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var rankType: UILabel!
    
    
    @IBOutlet weak var progresView: UIProgressView!
    
    
    @IBOutlet weak var doneWinLoseLabel: UILabel!
    
    @IBOutlet weak var rankAverageLabel: UILabel!
    
    @IBOutlet weak var rankTypeUseButton: UIButton!
    
    @IBOutlet weak var rankTypeUse: UIButton!
    
    
override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func rankProgress(with average:Double )  {
        let progres:CGFloat = CGFloat(average / 100)
        progresView.progress = Float(progres)
        
    }
    
    
    
    
}
