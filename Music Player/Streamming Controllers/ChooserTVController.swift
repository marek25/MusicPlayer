//
//  ChooserTVController.swift
//  Music Player
//
//  Created by OSX on 2/10/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import UIKit
import SwiftSoup
import CoreData
import SQLite3


struct HTML {
    var html : String?
    
}

struct Title {
   
}




struct DocumentToSave {
    
    let nameToSave : String
    let urlToSave : String
}


class ChooserTVController: UITableViewController{
    

    var dbLogic = DataBaseLogic()
    
    
    
    var myData : [String]?
    
    var aTags : [String]?
    
    var html: String = ""
    
    var urls = [String](){
        
        didSet{
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    var URLStringForSession: String =  "https://www.youtube.com/watch?v=86BmSaXZMHw&list=RD86BmSaXZMHw&start_radio=1"
    
    //    var URLStringForSession: String = "https://m.youtube.com/watch?v=0XazYz5fjos&list=PLRwOBqkqX-aPgVMzwPJ8hXj7fbhBxsNB0"
//    var URLStringForSession: String = "https://m.youtube.com/watch?v=0XazYz5fjos&list=PLRwOBqkqX-aPgVMzwPJ8hXj7fbhBxsNB0"
    
    let youtubeVar = "https://www.youtube.com"
    
    var rowAtIP : Int?
    
    var finalURL = [String]()
    
    var SongTitle : String = ""
    
    var dataThumbImage : [UIImage]?
    
    var urlToSend : String?
    
    var songAndURL : NameAndUrlCD?
    var CoreDataObject = [NameAndUrlCD]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var List = [DocumentToSave]() {
        willSet{
//            for SUrl in List {
//                dbLogic.possibleFunc(name: SUrl.nameToSave, url: SUrl.urlToSave)
//                tableView.reloadData()
//            }
        }
    }
    
    
    func dataReloader() {
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SplitSegue" {
            if let des = segue.destination as? YTStreamController {
                if let sent = urlToSend {
                des.url = sent
                }}}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        dbLogic.readValues()
        
        
        if songAndURL == nil {
                 counterOfUrls(urls: urls)
                
            }
                self.tableView.reloadData()
//        dbLogic.readValues()
        dbLogic.createAndLoadDatabase()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CoreDataObject.count == 0 {
          adderLoop(urlList: urls)
        }
        print("Core Data Object: \(CoreDataObject)")
        loadFromCoreData()
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return urls.count
//        return CoreDataObject.count
        
        
//        return (dataBaseLogic?.linkList.count)!
        return dbLogic.linkList.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
            urlToSend = urls[indexPath.row]
        
       
        print(urlToSend ?? "no data")
        
        performSegue(withIdentifier: "SplitSegue", sender: Any?.self)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       
//        cell.textLabel?.text = urls[indexPath.row]
//        cell.textLabel?.text = CoreDataObject[indexPath.row].nameCD
        
        
//        dbLogic.linkovi.url
        
        cell.textLabel?.text = """
                                
                                \(dbLogic.linkList[indexPath.row].name)
                                \(dbLogic.linkList[indexPath.row].url)
                            """
    
        return cell
    }
   

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
}


extension ChooserTVController {
    
    func scrapperData(url: String) {
        //        self.parserCompletionHandler = completionHandler
        let url = url
        if let initializedURL = URL.init(string: url) {
        let session = URLSession.shared
            let task = session.dataTask(with: initializedURL){ data, response, error in
            let error = error?.localizedDescription
            guard let data = data else {return }
            print(data)

            let EncoddedDocument = String(data: data, encoding: .utf8)
            
            
            
            self.html = EncoddedDocument ?? "no data"
            //                print(EncoddedDocument ?? "no data")
            //                print(self.html ?? "no data")
            self.parseWithSoup()
            
        }
        task.resume()
    }
    }
    
    
    func parseWithSoup() {
        
        do {
            let doc : Document = try SwiftSoup.parse(self.html )
            do {
//
//                let element = try doc.select("title").first()
//                let div = try doc.select("div").array()
//                let p = try doc.select("p").array()
                let a  = try doc.select("a").array()
//                let link = try a?.attr("href")
//                let textA = try a?.text()
//                let className = try a?.className()
//                let idName = try a?.id()
//
               
                
//                let recognitionkey = "list=PLRwOBqkqX-aPgVMzwPJ8hXj7fbhBxsNB0"
                let recognitionKeyByIndex = "index"
                let buggyWord = "index=32"
                
               
                
                for elementOfDIVTag in a {
                    let a = elementOfDIVTag
                    let specialA = try? a.getElementsByClass("compact-media-item-image")
                    
                    let titleInLoop = try a.attr("title")
                    let filteredHrefFromA = try a.attr("href")
                    let dataThumb = try a.attr("data-thumb")
//                    print("a TAG:\(a)")
//                    print("special A: \(specialA)")
//                    print("TITLOVI PRE LOOP-A: \(titleInLoop)")
//                    print("A TAGOVI: \(a)")
//                    print("data-thumb: \(dataThumb)")
                    
//                    dataThumbImage?.append(dataThumb)
                    if filteredHrefFromA.contains(recognitionKeyByIndex) &&  filteredHrefFromA.contains(buggyWord) == false {
//                        print("SUPER FILTERED LINKS: \(filteredHrefFromA)")
                        var filth = filteredHrefFromA
//                        print("------- FILTH: \(filth)")
//                        print("--------TITLOVI U LOOP-U: \(title)")
                        let finalLink =  youtubeVar + filth
                        
                        
                        
                        
                        urls.append(finalLink)
//                        print("TITLES FROM FILTERED URLS: \(titleInLoop)")
//                        print("link from finalLink: \(finalLink)")
                    }
                }
            }
        } catch {
        }
    }
}

//extension ChooserTVController {
//
//    func titleFetcherFromUrl(url: String) {
//        if  let InitializeURL = URL.init(string: url) {
//
//        let task = URLSession.shared.dataTask(with: InitializeURL) { data, response, error in
//        guard let data = data, error == nil else { return }
//
//
//            if  let EncoddedDocument = String(data: data, encoding: .utf8) {
//                self.parseTitleWithSoup(html: EncoddedDocument)
//            }
////        DispatchQueue.main.async() {    // execute on main thread
//////            self.imageView.image = UIImage(data: data)
////                print("image to display")
////
////
////        }
//        }
//        task.resume()
//        }
//}
//        func parseTitleWithSoup(html: String) {
//            do {
//                let doc : Document = try SwiftSoup.parse(self.html )
//                let element = try doc.select("title").first()
//                print("TITLE OF ELEMENT: \(String(describing: element))")
//                self.SongTitle = String(describing: element)
//            } catch {
//                print("nece da moze")
//            }
//        }
//}

extension ChooserTVController {
    
    func adderLoop(urlList: [String]) {
        if urlList.count != 0 {
            
            var counter = 0
            for url in urlList {
//                var song : String?
               
                    if  let InitializeURL = URL.init(string: url) {
                        let task = URLSession.shared.dataTask(with: InitializeURL) { data, response, error in
                            guard let data = data, error == nil else { return }
                            if  let EncoddedDocument = String(data: data, encoding: .utf8) {

                                    do {
                                        let doc : Document = try SwiftSoup.parse(EncoddedDocument)
                                        let element = try doc.select("title").first()
                                        
                                        
                                        
                                        let song = String(describing: element)
//                                        print("------SONG \(String(describing: song))")
//                                        print("------URL \(url)")
                                        
//                                        self.List.append(DocumentToSave(nameToSave: song, urlToSave: url))
                                        
                                        counter = counter + 1
                                        DispatchQueue.main.async {
                                            self.dbLogic.possibleFunc(name: song, url: url)
                                            self.tableView.reloadData()
                                        }
                                        
                                        
                                        print("-------------COUNTER IS:\(counter)")
                                        
//                                        self.dbLogic.possibleFunc(name: song, url: url)
                                        
                                        
                                        
//                                        print("LIST COUNT: \(self.List.count)")
//                                        print("""
//                                            LIST NAME: \(self.List[counter].nameToSave)
//                                            LIST URL: \(self.List[counter].urlToSave)
//                                            """)
                                        
                                        
                                        }catch {
                                        print("nece da moze")
                                    }
                            }
                        }
                        task.resume()
                }
               
            }
        }
    }
}

extension ChooserTVController {
    func counterOfUrls(urls: [String]) {
        if urls.count == 0 {
            scrapperData(url: URLStringForSession)
        }
    }
}


extension ChooserTVController {
    
    func loadFromCoreData(){
        let fetchRequest: NSFetchRequest<NameAndUrlCD> = NameAndUrlCD.fetchRequest()
        do{
            CoreDataObject = try context.fetch(fetchRequest)
            tableView.reloadData()
        }catch{
            print("Can not read from the database")
        }
    }
    
}


extension ChooserTVController {
    
}



