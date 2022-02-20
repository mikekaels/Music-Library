//
//  APIManager.swift
//  MusicLibrary
//
//  Created by Santo Michael Sihombing on 19/02/22.
//

import Foundation
import Alamofire
import CoreData

enum CustomError: Error {
    case noInternetConnection
    case unexpected
}

class APIManager {
    static let shared = APIManager()
    private let httpService = Service()
    
    func fetchChart(page: Int, pageSize: Int, completion: @escaping(Result<MusicModel, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .getChartSong(page: page, pageSize: pageSize)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        
                        do {
                            let result = try JSONDecoder().decode(MusicModel.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(.unexpected))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
    
    func findSongs(page: Int, pageSize: Int, songTitle: String, completion: @escaping(Result<MusicModel, CustomError>) -> Void) {
        if !Connectivity.isConnectedToInternet {
            completion(.failure(.noInternetConnection))
        } else {
            do {
                try APIRouter
                    .findSongs(page: page, pageSize: pageSize, songTitle: songTitle)
                    .request(usingHttpService: httpService)
                    .responseJSON { result in
                        guard [200, 201].contains(result.response?.statusCode), let data = result.data else { return }
                        
                        do {
                            let result = try JSONDecoder().decode(MusicModel.self, from: data)
                            completion(.success(result))
                        } catch {
                            completion(.failure(.unexpected))
                        }
                    }
                
            } catch {
                completion(.failure(error as! CustomError))
            }
        }
    }
    
    func fetchRandomImage(completion: @escaping([Image]) -> Void) {
            do {
                try APIRouter
                    .getRandomImage
                    .request(usingHttpService: httpService)
                    .responseJSON { response in
                        guard [200, 201].contains(response.response?.statusCode), let datas = response.data else { return }
                        do {
                            let result = try JSONDecoder().decode(Images.self, from: datas)
                            completion(result)
                        } catch {
                            print(error)
                        }
                    }
            } catch {
                
            }
    }
    
    //MARK: - CORE DATA
    
    func addData(songs: [SongsModel],  completion: @escaping(Result<[SongsModel], CustomError>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteSongs", in: context)
        
        var currentTracks: [SongsModel] = [SongsModel]()
            self.getAllSaved { savedSongs in
                songs.enumerated().forEach { (indexSong, newSong) in
                    if let index = savedSongs.firstIndex(where: { $0.id == newSong.id }) {
                        if index < 0 {
                            print("👉 1. Add a song called \(newSong.songTitle)...")
                            let newFavorite = FavoriteSongs(entity: entity!, insertInto: context)
                            newFavorite.id = newSong.id
                            newFavorite.songTitle = newSong.songTitle
                            newFavorite.singer = newSong.singer
                            newFavorite.dateAdded = newSong.dateAdded
                            newFavorite.saved = newSong.saved
                            do {
                                try context.save()
                                currentTracks.append(SongsModel(id: newSong.id, songTitle: newSong.songTitle, singer: newSong.singer, dateAdded: newSong.dateAdded, saved: newSong.saved, image: "https://images.unsplash.com/photo-1643131113414-6c65caa950bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDM3MTB8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NDUzODYwMDA&ixlib=rb-1.2.1&q=80&w=200"))
                            } catch {
                                print("SAVE ERROR")
                            }
                        } else {
                            currentTracks.append(SongsModel(id: newSong.id, songTitle: newSong.songTitle, singer: newSong.singer, dateAdded: newSong.dateAdded, saved: savedSongs[index].saved! as NSNumber, image: "https://images.unsplash.com/photo-1643131113414-6c65caa950bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDM3MTB8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NDUzODYwMDA&ixlib=rb-1.2.1&q=80&w=200"))
                        }
                    } else {
                        print("👉 2. Add a song called \(newSong.songTitle)...")
                        let newFavorite = FavoriteSongs(entity: entity!, insertInto: context)
                        newFavorite.id = newSong.id
                        newFavorite.songTitle = newSong.songTitle
                        newFavorite.singer = newSong.singer
                        newFavorite.dateAdded = newSong.dateAdded
                        newFavorite.saved = newSong.saved
                        do {
                            try context.save()
                            currentTracks.append(SongsModel(id: newSong.id, songTitle: newSong.songTitle, singer: newSong.singer, dateAdded: newSong.dateAdded, saved: newSong.saved, image: "https://images.unsplash.com/photo-1643131113414-6c65caa950bd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzMDM3MTB8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NDUzODYwMDA&ixlib=rb-1.2.1&q=80&w=200"))
                        } catch {
                            print("SAVE ERROR")
                        }
                    }
                }
            }
        completion(.success(currentTracks))
    }
    
    func getAllSaved(completion: @escaping([FavoriteSongs]) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
        //        let predicate = NSPredicate(format: "saved == 0")
        //        request.predicate = predicate
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            var resultSong: [FavoriteSongs] = [FavoriteSongs]()
            for result in results {
                let favsongs = result as! FavoriteSongs
                resultSong.append(favsongs)
            }
            completion(resultSong)
        }catch {
            print(error)
        }
    }
    
    func addToFavorite(id: NSNumber, completion: @escaping(Result<[FavoriteSongs], CustomError>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        
        var song: FavoriteSongs!
        
        do {
            let results = try? context.fetch(request)
            if results?.count == 0 {
                // here you are inserting
                song = FavoriteSongs(context: context)
            } else {
                // here you are updating
                song = results?.first as? FavoriteSongs
            }
            
            song.saved = 1
            try context.save()
        }catch {
            print(error)
        }
    }
    
    func getAllFavorite(completion: @escaping([FavoriteSongs]) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
        let predicate = NSPredicate(format: "saved == 1")
        request.predicate = predicate
        
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            var resultSong: [FavoriteSongs] = [FavoriteSongs]()
            for result in results {
                let favsongs = result as! FavoriteSongs
                resultSong.append(favsongs)
            }
            completion(resultSong)
        }catch {
            print(error)
        }
    }
    
    func deleteData(id: NSNumber, completion: @escaping(Result<[FavoriteSongs], CustomError>) -> Void) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteSongs")
        let predicate = NSPredicate(format: "id == %@", id)
        request.predicate = predicate
        
        var song: FavoriteSongs!
        
        do {
            let results = try? context.fetch(request)
            if results?.count == 0 {
                // here you are inserting
                song = FavoriteSongs(context: context)
            } else {
                // here you are updating
                song = results?.first as? FavoriteSongs
            }
            
            song.saved = 0
            try context.save()
        }catch {
            print(error)
        }
    }
}



