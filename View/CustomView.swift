//
//  CustomView.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-28.
//


import UIKit

class CustomView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Color
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3 ).cgColor
        // Opacity
        layer.shadowOpacity = 0.5
        // How far is spreads / blurs out
        layer.shadowRadius = 5.0
        
        // 1 down, 1 up
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 10.0
    }

}
