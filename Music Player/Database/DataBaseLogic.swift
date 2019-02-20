//
//  DataBaseLogic.swift
//  Music Player
//
//  Created by OSX on 2/17/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import Foundation
import SQLite3
import UIKit



class DataBaseLogic{

    lazy var chooserVC = ChooserTVController()
    
    var db: OpaquePointer?
    var linkList = [DataBase]()
    
func readValues(){
    linkList.removeAll()
    
    let queryString = "SELECT * FROM Songs"
    
    var stmt:OpaquePointer?
    
    if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error preparing insert: \(errmsg)")
        return
    }
    
    while(sqlite3_step(stmt) == SQLITE_ROW){
        let id = sqlite3_column_int(stmt, 0)
        let name = String(cString: sqlite3_column_text(stmt, 1))
        let url = String(cString: sqlite3_column_text(stmt, 2))
        
        linkList.append(DataBase(id: Int(id), name: String(describing: name), url: String(describing: url)))
    }
    self.chooserVC.dataReloader()
//    self.tableViewHeroes.reloadData()
}
    
    
    func createAndLoadDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("SongsDatabase.sqlite")
        
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
        print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Songs (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, url TEXT)", nil, nil, nil) != SQLITE_OK {
        let errmsg = String(cString: sqlite3_errmsg(db)!)
        print("error creating table: \(errmsg)")
        }
        
//        readValues()
        print("CREATED TABLE")
        
    
    }
    
    
    
    func possibleFunc(name: String, url: String){
        
        var stmt: OpaquePointer?
        
        let queryString = "INSERT INTO Songs (name, url) VALUES (?,?)"
        
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, url, -1, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure binding name: \(errmsg)")
            return
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("failure inserting hero: \(errmsg)")
            return
        }
        
//        textFieldName.text=""
//        textFieldPowerRanking.text=""
        
        readValues()
    }
    
    
    func deleteSongFromTable(nameOfTable: String, indexPath: Int) {
        let deleteStatementStirng = "DELETE FROM \(nameOfTable) WHERE Id = \(indexPath);"
        
        func delete() {
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted all.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            
            sqlite3_finalize(deleteStatement)
        }
        
    }
    
    
    func deleteAllFromTable(nameOfTable: String) {
        let deleteStatementStirng = "DELETE FROM \(nameOfTable) WHERE Id = 1;"
        
        func delete() {
            var deleteStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
                if sqlite3_step(deleteStatement) == SQLITE_DONE {
                    print("Successfully deleted all.")
                } else {
                    print("Could not delete row.")
                }
            } else {
                print("DELETE statement could not be prepared")
            }
            
            sqlite3_finalize(deleteStatement)
        }
    }
    
    
    let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("SongsDatabase.sqlite")
    
   
    
    
    func destroyer() {
        do{
            let fileUrl = String(describing: fileURL)
            if FileManager.default.fileExists(atPath: fileUrl){
                try FileManager.default.removeItem(atPath: fileUrl)
                print("Deleted Database")
            }
        }catch{
            print("Can not be deleted")
        }
    }
    
    
    
    
//    let tutorialDirectoryUrl = playgroundSharedDataDirectory.appendingPathComponent("SQLiteTutorial").resolvingSymlinksInPath
    
//    private enum Database: String {
//        case Part1
//        case Part2
//
////        var path: String {
////            return tutorialDirectoryUrl().appendingPathComponent("\(self.rawValue).sqlite").relativePath
////        }
//    }
//
//    public let part1DbPath = Database.Part1.path
//    public let part2DbPath = Database.Part2.path
//
//
//    private func destroyDatabase(db: Database) {
//        do {
//            if FileManager.default.fileExists(atPath: db.path) {
//                try FileManager.default.removeItem(atPath: db.path)
//            }
//        } catch {
//            print("Could not destroy \(db) Database file.")
//        }
//    }
//
//    public func destroyPart1Database() {
//        destroyDatabase(db: .Part1)
//    }
    
//    public func destroyPart2Database() {
//        destroyDatabase(db: .Part2)
//    }
    
}
