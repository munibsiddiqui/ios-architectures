//
//  SqliteManager.swift
//  MVVM-RxSwift-sqlite
//
//  Created by GoEun Jeong on 2021/05/05.
//

import Foundation
import SQLite3

protocol LocalManager {
    func saveBeer(beer: Beer)
    func getLocalBeerList(page: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
    func searchLocalID(id: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
    func localRandom(completion: @escaping ((Result<[Beer], NetworkingError>) -> Void))
}

class SqliteManager: LocalManager {
    var db: OpaquePointer? // SQLite Object
    var stmt:OpaquePointer? // statement Object
    
    init() {
        opendb()
    }
    
    func opendb(){
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("beer.sqlite3")
        
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
            print("Success To Open DB")
        }
        print(fileURL)
        
        // if not exist, crreate table
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Beer (id INTEGER, name TEXT, desc TEXT, imageURL TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Failed to create table: \(errmsg)")
        }
    }
    
    func saveBeer(beer: Beer) {
        deleteBeer(beer: beer)
        let queryString = "INSERT INTO Beer (id, name, desc, imageURL) Values (\(String(describing:beer.id ?? 0)), \"\(String(describing: beer.name ?? ""))\", \"\(String(describing: beer.description ?? ""))\", \"\(String(describing: beer.imageURL ?? ""))\")"
        
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        // excute query
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Failed To Insert \(errmsg)")
            return
        }
    }
    
    func getLocalBeerList(page: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        var beerArray = [Beer]()
        let queryString = "SELECT * FROM Beer WHERE id >= \((page - 1) * 25 - 1) AND id <= \(page * 25)"
        
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            completion(.failure(NetworkingError.error("DB Query Error")))
        }
        
        // traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let desc = String(cString: sqlite3_column_text(stmt, 2))
            let imageURL = String(cString: sqlite3_column_text(stmt, 3))
            //adding values to list
            beerArray.append(Beer(id: Int(id), name: name, description: desc, imageURL: imageURL))
            
        }
        
        if beerArray.isEmpty {
            completion(.failure(NetworkingError.defaultError))
        } else {
            completion(.success(beerArray))
        }
    }
    
    func searchLocalID(id: Int, completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        var beerArray = [Beer]()
        let queryString = "SELECT * FROM beer WHERE id = \(id)"
        
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            completion(.failure(NetworkingError.error("DB Query Error")))
        }
        
        // traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let desc = String(cString: sqlite3_column_text(stmt, 2))
            let imageURL = String(cString: sqlite3_column_text(stmt, 3))
            //adding values to list
            beerArray.append(Beer(id: Int(id), name: name, description: desc, imageURL: imageURL))
            
        }
        if beerArray.isEmpty {
            completion(.failure(NetworkingError.defaultError))
        } else {
            completion(.success(beerArray))
        }
    }
    
    func localRandom(completion: @escaping ((Result<[Beer], NetworkingError>) -> Void)) {
        var beerArray = [Beer]()
        let queryString = "SELECT * FROM beer ORDER BY RANDOM() LIMIT 1"
        
        // preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
            completion(.failure(NetworkingError.error("DB Query Error")))
        }
        
        // traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let desc = String(cString: sqlite3_column_text(stmt, 2))
            let imageURL = String(cString: sqlite3_column_text(stmt, 3))
            //adding values to list
            beerArray.append(Beer(id: Int(id), name: name, description: desc, imageURL: imageURL))
            
        }
        
        if beerArray.isEmpty {
            completion(.failure(NetworkingError.defaultError))
        } else {
            completion(.success(beerArray))
        }
    }
    
    private func deleteBeer(beer: Beer) {
        
        let queryString = "DELETE FROM Beer WHERE id = \(beer.id ?? 0)"
        
        // 쿼리 준비
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        //삽입 값 쿼리 실행
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("Failed To Insert \(errmsg)")
            return
        }
    }
}
