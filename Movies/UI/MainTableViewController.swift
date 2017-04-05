//
//  MainTableViewController.swift
//  Movies
//
//  Created by Alexandre Malkov on 29/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class MainTableViewController : UITableViewController {

    let presenter = Presenter.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.pullUpdates()
        updatePageTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks,
                                                            target: self,
                                                            action: #selector(favoriteButtonAction))
    }
    
    func favoriteButtonAction() {
        presenter.favoriteMode = !presenter.favoriteMode
        updatePageTitle()
        tableView.reloadData()
    }
    
    func updatePageTitle() {
        navigationItem.title = presenter.favoriteMode ? "Favorites" : "Home"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presenter.getSectionsCount()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        label.backgroundColor = UIColor.init(colorLiteralRed: 0.655, green: 0.882, blue: 0.996, alpha: 1.00)
        label.textAlignment = .center
        label.text = presenter.getSectionTitle(section: section)
        return label
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter.getRowsForSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell

        let item = presenter.getItyemForIndexPath(indexPath: indexPath)
        
        cell.indexPath = indexPath
        cell.titleLabel.text = item.title
        cell.synopsisLabel.text = item.synopsis
        
        let buttonImage = item.favorite ? UIImage(named: "HeartOn") : UIImage(named: "HeartOff")
        cell.favoriteButton.setBackgroundImage(buttonImage, for: .normal)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectetIndexPath = indexPath
        performSegue(withIdentifier: "showDetails", sender: self)
    }
}

extension MainTableViewController : PresenterDelegate {
    
    func presenterDataUpdated() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
