//
//  ReflectVC.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-28.
//

import UIKit
import DGCharts

class ReflectVC: UIViewController {

    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var reflectLbl: UILabel!
    
    @IBOutlet weak var cycleBtn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cycleTap = UITapGestureRecognizer(target: self, action: #selector(self.cycleTapped(_:)))
        cycleBtn.addGestureRecognizer(cycleTap)

        
reflectLbl.font = UIFont(name:"Roboto-SemiBold",size:30)
       
    }
    
    
    
    @objc func cycleTapped(_ sender: UITapGestureRecognizer? = nil) {
//        selectedData += 1
//        updateChart()
//        if selectedData == 6 {
//            selectedData = 0
//        }
        
    }
    


}
