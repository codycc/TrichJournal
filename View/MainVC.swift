//
//  MainVC.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-26.
//

import UIKit
import CoreData
import CSV




class MainVC: UIViewController {
    
     
    
    var incidents = [Incident]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var addIncidentImage: UIImageView!
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    
    @IBOutlet weak var addIncidentNewBtn: UIImageView!
    
    @IBOutlet weak var backgroundAddImage: UIView!
    
    @IBOutlet weak var sortBtn: UIImageView!
    
    @IBOutlet weak var sortLbl: UILabel!
    
    @IBOutlet weak var downloadCSVBtn: UIImageView!
    
    
    var currentSortId = 1
    
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
        let sortTap = UITapGestureRecognizer(target: self, action: #selector(self.sortTapped(_:)))
        sortBtn.addGestureRecognizer(sortTap)
        mainTableView.register(UINib(nibName: "IncidentCell", bundle: nil), forCellReuseIdentifier: "IncidentCell")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        
        let downloadTap = UITapGestureRecognizer(target: self, action: #selector(self.downloadTapped(_:)))
        downloadCSVBtn.addGestureRecognizer(downloadTap)
        
        loadIncidents()
        sortDate()
    }
    
    
    
    
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
    
    func sortDate() {
        incidents = incidents.sorted(by: { $0.dateTime < $1.dateTime })
        mainTableView.reloadData()
    }
    
    func sortEntries() {
       
        switch currentSortId {
        case 1:
            sortLbl.text = "Hairs"
            incidents = incidents.sorted(by: { $0.numberOfHairsPulled < $1.numberOfHairsPulled })
            
        case 2:
            sortLbl.text = "Intensity"
            incidents = incidents.sorted(by: { $0.intensity < $1.intensity })
            
        case 3:
            sortLbl.text = "Length of Time"
            incidents = incidents.sorted(by: { $0.howLong < $1.howLong })
            
        case 4:
            sortLbl.text = "Date"
            incidents = incidents.sorted(by: { $0.dateTime < $1.dateTime })

        default:
            print("hello")
            
        }
        
    }
    
    func createCSV(){
        let fileName =  "trichJournalLog1.csv"
        var csvText = "Date,# Of Hairs, length(minutes), Digested?, Area, Situation\n"
        
        for incident in incidents {
            let date = NSDate(timeIntervalSince1970: incident.dateTime)
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let finalDate = formatter.string(from: date as Date)
            let stringDate = String(describing: finalDate)
            
            let newLine = "\(stringDate),\(incident.numberOfHairsPulled),\(incident.howLong),\(incident.didYouDigest),\(incident.areaAffected!), \(incident.situation!)\n"
            csvText.append(newLine)
        }


            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

                let fileURL = dir.appendingPathComponent(fileName)

                do {
                    try csvText.write(to: fileURL, atomically: false, encoding: .utf8)
                    let doc = UIDocument(fileURL: fileURL)
                    UIApplication.shared.keyWindow?.tintColor = .systemBlue
                    let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                               self.present(activityViewController, animated: true, completion: nil)
                    
                       // just send back the first one, which ought to be the only one
                       
                } catch {

                   // print("this is  the error \(error)")

                }
            }
        
    
      
            
     

    }
    
    @objc func goToNewEntryVC() {
        performSegue(withIdentifier: "goToAddEntryVC", sender: nil)
    }
    
    @objc func sortTapped(_ sender: UITapGestureRecognizer? = nil) {
        if currentSortId == 5 {
            currentSortId = 1
        }
        sortEntries()
        mainTableView.reloadData()
        currentSortId += 1
    }
    
    @objc func downloadTapped(_ sender: UITapGestureRecognizer? = nil) {
        createCSV()
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
