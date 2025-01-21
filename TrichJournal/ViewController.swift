//
//  ViewController.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          initialSetup()
       }
           
    private func callAnimation() {
        var charIndex = 0.0
        let titleText = "Welcome to TrichJournal"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.3 * charIndex, repeats: false) { timer in
                self.welcomeLabel.text?.append(letter)
            }
            
            charIndex += 1
        }
    }
       private func initialSetup() {
           callAnimation()
          // basic setup
          view.backgroundColor = .white
           welcomeLabel.font = UIFont(name:"Roboto-ExtraLight",size:15)
           welcomeLabel.font = welcomeLabel.font.withSize(50)
          
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
    

    
   


}

