//
//  MainTableViewCell.swift
//  Movies
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!

    
    var indexPath: IndexPath = IndexPath()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        let presenter = Presenter.sharedInstance
        presenter.toggleFavorite(indexPath: indexPath)
    }

}
