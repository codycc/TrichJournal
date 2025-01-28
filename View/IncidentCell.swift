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
    @IBOutlet weak var intensityLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var numberOfHairsLbl: UILabel!
    @IBOutlet weak var didYouDigestLbl: UILabel!
    @IBOutlet weak var lengthOfTimeLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
   
    
    func configureCell(incident: Incident ) {
        
        incidentLabel.font = UIFont(name:"Roboto-SemiBold",size:30)
        incidentLabel.text = incident.situation
        lengthOfTimeLbl.text = String("\(incident.howLong) minutes")
        numberOfHairsLbl.text = String(incident.numberOfHairsPulled)
        areaLbl.text = incident.areaAffected
        if incident.didYouDigest == true {
            didYouDigestLbl.text = "Yes"
        } else {
            didYouDigestLbl.text = "No"
        }
        
        
        let date = NSDate(timeIntervalSince1970: incident.dateTime)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        let finalDate = formatter.string(from: date as Date)
        let finalTime = timeFormatter.string(from: date as Date)
        timeLbl.text = String(describing: finalTime)
        dateLbl.text = String(describing: finalDate)
        intensityLbl.text = String(incident.intensity)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
    
   
    
}




