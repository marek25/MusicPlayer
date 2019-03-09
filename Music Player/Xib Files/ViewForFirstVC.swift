//
//  ViewForFirstVC.swift
//  Music Player
//
//  Created by OSX on 3/3/19.
//  Copyright © 2019 AppDoctor. All rights reserved.
//

import UIKit

class ViewForFirstVC: UIView {
    
    let dbLogic = DataBaseLogic()
    
    weak var initialViewController = InitialVController()
    
    
    @IBOutlet weak var firstLabel: UITextField!
    
    @IBOutlet weak var secondLabel: UITextField!
    
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    
    @IBOutlet weak var firstXibImage: UIImageView!
    
    
    @IBOutlet weak var DBCommPlayList: UIButton!
    @IBOutlet weak var DBCommAuthor: UIButton!
    @IBOutlet weak var DBCommGramophone: UIButton!
    @IBOutlet weak var DBCommSaveButton: UIButton!
    @IBOutlet weak var DBCommBackButton: UIButton!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let _ = loadViewFromNib()
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "UrlAndTable", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        //        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        
        
        firstLabel.layer.borderColor = UIColor.black.cgColor
        firstLabel.layer.borderWidth = 2.0
        
        secondLabel.layer.borderColor = UIColor.black.cgColor
        secondLabel.layer.borderWidth = 2.0
        
        saveButtonOutlet.layer.borderWidth = 2.0
        saveButtonOutlet.layer.borderColor = UIColor.black.cgColor
        
        return view
    }
    
    func loadViewFromNibDatabaseCommands() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "DatabaseCommands", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        //        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        return view
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        initialViewController?.view.endEditing(true)
        
        self.initialViewController?.hideKeyboard()
        
        let originalXPositionSaveButton = saveButtonOutlet.center.x
        let originalYPositionSaveButton = saveButtonOutlet.center.y
        
        let originalXPositionImageView = firstXibImage.center.x
        let originalYPositionImageView = firstXibImage.center.y
        
        UIView
            .animateKeyframes(withDuration: 2.0,
                                delay: 0.0,
                                options: [.calculationModeCubic],
                                animations: {
                                    
                                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.20, animations: { [weak self] in
                                        self?.saveButtonOutlet.transform = CGAffineTransform(rotationAngle: -.pi / 2)
//                                        self.planeImage.transform = CGAffineTransform(rotationAngle: -.pi / 8)
                                        self?.saveButtonOutlet.center.x = originalXPositionImageView
                                        
                                        self?.firstXibImage.transform = CGAffineTransform(rotationAngle: .pi / 2)
                                        self?.saveButtonOutlet.alpha = 0.5
                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.20, relativeDuration: 0.20, animations: {[weak self] in
                                        self?.firstXibImage.transform = .identity
                                        self?.saveButtonOutlet.alpha = 0.0
  
                                        self?.saveButtonOutlet.transform = .identity
                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.40, relativeDuration: 0.20, animations: {[weak self] in
                                        
                                        self?.firstXibImage.center.y += 1000
                                        self?.firstXibImage.alpha = 0.0
                                        
                                        
                                        self?.saveButtonOutlet.center.x = originalXPositionSaveButton
                                        
                                        
                                        
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.60, relativeDuration: 0.20, animations: { [weak self] in
                                        
                                        
                                        self?.firstXibImage.center.y = originalYPositionImageView
                                    })
                                    UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.20, animations: { [weak self] in
                                            self?.layoutIfNeeded()
                                            self?.firstXibImage.alpha = 1.0
                                            self?.saveButtonOutlet.alpha = 1.0
                                        
                                    })

                                    
                                }) { [weak self](true) in
                                    if let name = self?.firstLabel.text, let url = self?.secondLabel.text  {
                                        self?.dbLogic.createSpecificTableAndLoadDatabase(tableName: name)
//                                        self?.loadViewFromNibDatabaseCommands()
                                }
            }
    }
    
    
    @IBAction func gramophoneIcon(_ sender: Any) {
        
        if self.DBCommPlayList.isHidden == true, self.DBCommAuthor.isHidden == true {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: [.transitionCurlDown], animations: { [weak self] in
                
                
                
                self?.DBCommPlayList.alpha = 1.0
                self?.DBCommAuthor.alpha = 1.0
                self?.DBCommPlayList.isHidden = false
                self?.DBCommAuthor.isHidden = false
            }, completion: nil)
        
        
        } else {
            UIView.animate(withDuration: 1.5, delay: 0.0, options: [.transitionCrossDissolve,], animations: { [weak self] in
                
                
                self?.DBCommPlayList.alpha = 0.0
                self?.DBCommAuthor.alpha = 0.0
                self?.DBCommPlayList.isHidden = true
                self?.DBCommAuthor.isHidden = true
                }, completion: nil)
        }
        
    }
    
    
    
    @IBAction func playList(_ sender: Any) {
        
        
        
    }
    
    @IBAction func AuthorsList(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func DBCOmmandsSave(_ sender: Any) {
        
        
        
    }
    
    
    
    @IBAction func DBCommBuBack(_ sender: Any) {
    }
    
    
    
    
    
    deinit {
        print("ViewForFirstVC deinitialized")
    }
    

}
