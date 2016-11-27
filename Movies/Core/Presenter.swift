//
//  MainController.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation

protocol PresenterDelegate {
    func dataUpdated()
}

class Presenter {
    
    static let presenter = Presenter()
    
    func pullUpdates() {
        
    }
    
    func getSectionsCount() -> Int {
        return 0
    }
    
    func getSectionTitle() -> String {
        return ""
    }
    
    func getRowsForSection(_ section: Int) -> Int {
        return 0
    }
    
    func getItyemForIndexPath(indexPath: NSIndexPath) -> PresentedItem {
        return PresentedItem(uid: "", title: "", synopsis: "", favorite: false)
    }
    
    func toggleFavorite(indexPath: NSIndexPath) {
        
    }
}
