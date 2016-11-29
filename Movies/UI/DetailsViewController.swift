//
//  DetailsViewController.swift
//  Movies
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var favoriteButton: UIButton?
    
    let presenter = Presenter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Episode details"
        
        let presenterItem = presenter.getItyemForIndexPath(indexPath: presenter.selectetIndexPath)
        titleLabel.text = presenterItem.title
        synopsisLabel.text = presenterItem.synopsis
        
        let buttonImage = presenterItem.favorite ? UIImage(named: "HeartOn") : UIImage(named: "HeartOff")
        favoriteButton = UIButton(type: .custom)
        favoriteButton?.setBackgroundImage(buttonImage, for: .normal)
        favoriteButton?.frame = CGRect(x: 0, y: 0, width: (buttonImage?.size.width)!, height: (buttonImage?.size.height)!)
        favoriteButton?.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = favoriteButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func favoriteButtonAction() {
        presenter.toggleFavorite(indexPath: presenter.selectetIndexPath)
        let presenterItem = presenter.getItyemForIndexPath(indexPath: presenter.selectetIndexPath)
        let buttonImage = presenterItem.favorite ? UIImage(named: "HeartOn") : UIImage(named: "HeartOff")
        favoriteButton?.setBackgroundImage(buttonImage, for: .normal)
    }

}
