//
//  ViewController.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-21.
//

import UIKit
import Foundation

class WelcomeVC: UIViewController {

    @IBOutlet weak var welcomeBtn: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var additionalTextLbl: UILabel!
    let welcomeScreenShown = UserDefaults.standard.bool(forKey: "welcomeScreenShown")
    override func viewDidLoad() {
          super.viewDidLoad()
          initialSetup()
       }
    
    override func viewDidAppear(_ animated: Bool) {
        showLabels()
        
        if welcomeScreenShown {
            self.performSegue(withIdentifier: "goToMainVC", sender: nil)
        } else {
          
        }
        
      
        
    }
           
    
       private func initialSetup() {
           
          // basic setup
          view.backgroundColor = .white
           welcomeLabel.font = UIFont(name:"Roboto-ExtraLight",size:50)
           
           additionalTextLbl.font = UIFont(name:"Roboto-ExtraLight",size:30)
           
           
           welcomeBtn.layer.cornerRadius = 15
           welcomeBtn.titleLabel?.font =  UIFont(name: "Roboto-SemiBold", size: 28)
          
          // Create a new gradient layer
          let gradientLayer = CAGradientLayer()
          // Set the colors and locations for the gradient layer
           gradientLayer.colors = [UIColor.white.cgColor, UIColor(red: 190/255, green: 255/255, blue: 255/255, alpha: 1).cgColor]
          gradientLayer.locations = [0.0, 1.0]

          // Set the start and end points for the gradient layer
          gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
          gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

          // Set the frame to the layer
          gradientLayer.frame = view.frame

          // Add the gradient layer as a sublayer to the background view
          view.layer.insertSublayer(gradientLayer, at: 0)
       }
    
    func showLabels() {
   
        UIView.animate(withDuration: 2.0) {
               self.welcomeLabel.alpha = 1.0
            
           }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            UIView.animate(withDuration: 2.0) {
                self.additionalTextLbl.alpha = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    UIView.animate(withDuration: 2.0) {
                           self.welcomeBtn.alpha = 1.0
                        
                       }
                }
               }
        }
        
      
        
        
        
       
    }
    
 
    @IBAction func welcomeBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToMainVC", sender: self)
//        let welcomeScreenShown = UserDefaults.standard.bool(forKey: "welcomeScreenShown")
        UserDefaults.standard.set(true, forKey: "welcomeScreenShown")
        
    }
    
    //test
    
    
   


}

