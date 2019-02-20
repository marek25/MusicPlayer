//
//  YTStreamController.swift
//  Music Player
//
//  Created by OSX on 2/10/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import UIKit
import YouTubePlayer

class YTStreamController: UIViewController {
    
    var url = "https://m.youtube.com/watch?v=0XazYz5fjos&list=PLRwOBqkqX-aPgVMzwPJ8hXj7fbhBxsNB0"
    
    var realUrl : String?
    
    let chooserVC = ChooserTVController()
    lazy var dbLogic = DataBaseLogic()
    
    @IBOutlet weak var yTubeView: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbLogic.destroyer()
        
        chooserVC.scrapperData(url: url)
        
        // Do any additional setup after loading the view.
        if let InitializedURL = URL(string: url) {
            yTubeView.loadVideoURL(InitializedURL)
        }
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            
            print("viewDidLoad: iPAD Detected")
   
            DispatchQueue.main.async {
                self.chooserVC.dataReloader()
            }
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
 
            
            if UIDevice.current.orientation.isPortrait {
                print("viewDidAppear: LANDSCAPE MODE")
                yTubeView.removeConstraints(yTubeView.constraints)
                print("Constraints removed")
            }
        }
        
        print("viewDidAppear")
        
        
        
            
        }
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
