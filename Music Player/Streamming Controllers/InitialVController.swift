//
//  InitialVController.swift
//  Music Player
//
//  Created by OSX on 2/20/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import UIKit


class InitialVController: UIViewController {

    
    
    @IBOutlet weak var TableViewInitial: UITableView!
    @IBOutlet weak var initialVCFirstView: UIView!
    
    var items = ["first", "second", "third", "fourth", "fifth"]
    
    let dbLogic = DataBaseLogic()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        
        self.TableViewInitial.delegate = self
        self.TableViewInitial.dataSource = self
        self.hideKeyboardWhenTappedAround()
        
        
        
        
//        dbLogic.readValues()
        // Do any additional setup after loading the view.
    }
    
    

}

extension InitialVController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}


extension InitialVController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 2.0
        
       
            cell.textLabel?.textColor = .black
            cell.textLabel?.text = items[indexPath.row]
//            cell.imageView?.image = UIImage(named: "delete")
        return cell
    }
    
    
    
    
}
