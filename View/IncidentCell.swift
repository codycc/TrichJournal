//
//  IncidentCell.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-26.
//

import UIKit

class IncidentCell: UITableViewCell {

    @IBOutlet weak var incidentLabel: UILabel!
   
  
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
   
    
    func configureCell(incident: Incident ) {
        
        containerView.dropShadow()
        incidentLabel?.text = incident.situation
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
    
   
    
}

extension UIView {

  func dropShadow() {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.6
      layer.shadowOffset = CGSize.zero
      layer.shadowRadius = 4.0
      layer.cornerRadius = 2.0
      //layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
      
      layer.shouldRasterize = true
      layer.rasterizationScale = UIScreen.main.scale
  }
}


