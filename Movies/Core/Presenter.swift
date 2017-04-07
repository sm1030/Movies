//
//  MainController.swift
//  Movies
//
//  Created by Alexandre Malkov on 27/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import Foundation
import CoreData

protocol PresenterDelegate : class {
    func presenterDataUpdated()
}

class Presenter {
    
    static let sharedInstance = Presenter()
    
    weak var delegate: PresenterDelegate?
    var api: ApiService?
    var favoriteMode = false
    var selectetIndexPath = IndexPath()
    
    func pullUpdates() {
        if api == nil {
            api = ApiService(delegate: self)
            
            #if MOCKUP
                api?.useMockUpData = true
                
                Schedule.deleteAll()
                Film.deleteAll()
                Favorite.deleteAll()
            #endif
        }
        
        api?.requestHomeData()
    }
    
    func getSectionsCount() -> Int {
        if favoriteMode {
            return 1
        } else {
            return Schedule.getAllDividers().count
        }
    }
    
    func getSectionTitle(section sectionId: Int) -> String {
        if favoriteMode {
            return "Favorites"
        } else {
            let sections = Schedule.getAllDividers()
            if sections.count > sectionId {
                return sections[sectionId]
            } else {
                return ""
            }
        }
    }
    
    func getRowsForSection(_ sectionId: Int) -> Int {
        if favoriteMode {
            return getFavoriteFilms().count
        } else {
            let dividers = Schedule.getAllDividers()
            if dividers.count > sectionId {
                return Schedule.getFilmUids(forDividerName: dividers[sectionId]).count
            } else {
                return 0
            }
            
        }
    }
    
    func getItyemForIndexPath(indexPath: IndexPath) -> PresentedItem {
        if favoriteMode {
            let films = getFavoriteFilms()
            if films.count > indexPath.row {
                let film = films[indexPath.row]
                return PresentedItem(uid: film.uid ?? "", title: film.title ?? "", synopsis: film.synopsis ?? "", favorite: true)
            }
        } else {
            let dividers = Schedule.getAllDividers()
            if dividers.count > indexPath.section {
                let filmUids = Schedule.getFilmUids(forDividerName: dividers[indexPath.section])
                if filmUids.count > indexPath.row {
                    let filmUid = filmUids[indexPath.row]
                    let film = Film.getInstance(uid: filmUid)
                    let favorite = Favorite.isFavorite(film_uid: filmUid)
                    return PresentedItem(uid: film?.uid ?? "", title: film?.title ?? "", synopsis: film?.synopsis ?? "", favorite: favorite)
                }
            }
        }
        
        return PresentedItem(uid: "", title: "", synopsis: "", favorite: false)
    }
    
    func getFavoriteFilms() -> [Film] {
        var favoriteFilms = [Film]()
        let schedules = Schedule.getAll() ?? [Schedule]()
        for schedule in schedules {
            if let uid = schedule.film_uid {
                if Favorite.isFavorite(film_uid: uid) {
                    if let film = Film.getInstance(uid: uid) {
                        favoriteFilms.append(film)
                    }
                }
            }
        }
        return favoriteFilms
    }
    
    func toggleFavorite(indexPath: IndexPath) {
        let item = getItyemForIndexPath(indexPath: indexPath)
        Favorite.toggleFavorite(film_uid: item.uid)
        delegate?.presenterDataUpdated()
    }
}

extension Presenter : ApiServiceDelegate {
    
    func apiServiceDataReceived() {
        delegate?.presenterDataUpdated()
    }
}
