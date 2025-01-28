//
//  MainVC.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-26.
//

import UIKit
import CoreData

class MainVC: UIViewController {
    
     
    
    var incidents = [Incident]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var addIncidentImage: UIImageView!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var addIncidentNewBtn: UIImageView!
    
    @IBOutlet weak var backgroundAddImage: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTitleLabel.font = UIFont(name:"Roboto-ExtraLight",size:30)
        backgroundAddImage.layer.cornerRadius = backgroundAddImage.frame.size.width/2
        backgroundAddImage.clipsToBounds = true

        backgroundAddImage.layer.borderColor = UIColor.white.cgColor
        backgroundAddImage.layer.borderWidth = 5.0

        let goToAddIncidentTapped = UITapGestureRecognizer(target: self, action: #selector(goToNewEntryVC))
        addIncidentNewBtn.addGestureRecognizer(goToAddIncidentTapped)
        loadIncidents()
        
        mainTableView.register(UINib(nibName: "IncidentCell", bundle: nil), forCellReuseIdentifier: "IncidentCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
    }
    
    //test
    
    // MARK: - Data manipulation methods
    
    @objc func reloadTable() {
        loadIncidents()
       /// currentSortId -= 1
        //sortEntries()
       // currentSortId += 1
        mainTableView.reloadData()
    }
    
    func loadIncidents() {
        let request : NSFetchRequest<Incident> = Incident.fetchRequest()
        
        do {
            incidents = try context.fetch(request)
        } catch {
            print("Error loading incidents\(error)")
        }
    }
    
    @objc func goToNewEntryVC() {
        performSegue(withIdentifier: "goToAddEntryVC", sender: nil)
    }
    
    

   

}



extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incidents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "IncidentCell", for: indexPath) as! IncidentCell
        let incident = incidents[indexPath.row]
        cell.configureCell(incident: incident)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 173.00
    }
    
    
    
    
    
    
    
}
