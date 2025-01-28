//
//  NewEntryVC.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-26.
//

import UIKit
import CoreData

class NewEntryVC: UIViewController {
    
    @IBOutlet weak var intensityControl: UISlider!
    
    @IBOutlet weak var dateTimeTextField: CustomTextField!
    
    @IBOutlet weak var situationTextField: CustomTextField!
    
    @IBOutlet weak var howLongTextField: CustomTextField!
    
    @IBOutlet weak var numberOfHairsTextField: CustomTextField!
    
    @IBOutlet weak var didYouDigestControl: UISegmentedControl!
    
    @IBOutlet weak var affectedAreasTextField: CustomTextField!
    
    @IBOutlet weak var addEntryLabel: UILabel!
    
    @IBOutlet weak var backBtn: UIImageView!
    
    var situations = [Situation]()
    
    let situationPicker = UIPickerView()
    let affectedAreaPicker = UIPickerView()
    var selectedSituation: String = ""
    var selectedArea: String = ""
    var timeSince1970 = 0.0
    var affectedAreas = ["Eyebrows","Eyelashes","Scalp","Legs","Arms", "Pubic Area", "Nose", "Chest","Hands","Face","Toe","Foot","Underarm","Thigh","Stomach","Ear"]
    private var datePicker: UIDatePicker?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let requestSituation = NSFetchRequest<NSFetchRequestResult>(entityName: "Situation")
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        situationTextField.delegate = self
        dateTimeTextField.delegate = self
        howLongTextField.delegate = self
        numberOfHairsTextField.delegate = self
        affectedAreasTextField.delegate = self
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        backBtn.addGestureRecognizer(backTap)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        addEntryLabel.font = UIFont(name:"Roboto-SemiBold",size:30)
        // Do any additional setup after loading the view.
        
        createSituationPicker()
        createAffectedAreasPicker()
        createDatePicker()
        fetchSituationData()
        checkIfTextFieldsEmpty()
    }
    
    func createDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        dateTimeTextField.inputView = datePicker
        datePicker?.preferredDatePickerStyle = .wheels
        datePicker?.addTarget(self, action: #selector(NewEntryVC.dateDoneClicked(datePicker:)), for: .valueChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func fetchSituationData() {
        situations = []
        do {
            let results = try context.fetch(requestSituation)
            if results.count > 0 {
                for result in results {
                    situations.append(result as! Situation)
                }
            }
           // selectedSituation = situations[0].place!
        } catch {
            // handle error
        }
    }
    
    func createSituationPicker() {
        situationPicker.delegate = self
        situationTextField.inputView = situationPicker
    }
    
    func createAffectedAreasPicker() {
        affectedAreaPicker.delegate = self
        affectedAreasTextField.inputView = affectedAreaPicker
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       checkIfTextFieldsEmpty()
    }
    
    func checkIfTextFieldsEmpty() {
        if self.dateTimeTextField.text!.isEmpty  || self.situationTextField.text!.isEmpty  || self.howLongTextField.text!.isEmpty  || numberOfHairsTextField.text!.isEmpty  || affectedAreasTextField.text!.isEmpty  {
            self.submitBtn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            self.submitBtn.isEnabled = false
            self.submitBtn.setTitle("Please fill all fields to submit.", for: .normal)
        } else {
            self.submitBtn.backgroundColor = #colorLiteral(red: 0.6510000229, green: 0.8629999757, blue: 0.9369999766, alpha: 1)
            self.submitBtn.isEnabled = true
            self.submitBtn.setTitle("Submit", for: .normal)
        }
    }
    
    func createIncident() {
        var newIncident = Incident(context: context)
        newIncident.intensity = Int32(intensityControl.value)
        newIncident.dateTime = timeSince1970
        newIncident.situation = situationTextField.text!
        newIncident.howLong = Int32(howLongTextField.text!)!
        newIncident.numberOfHairsPulled = Int32(numberOfHairsTextField.text!)!
        newIncident.areaAffected = affectedAreasTextField.text
        switch didYouDigestControl.selectedSegmentIndex {
        case 0:
            newIncident.didYouDigest = true
        case 1:
            newIncident.didYouDigest = false
        default:
            newIncident.didYouDigest = false
        }
        print(Int32(intensityControl.value))
        saveItem()
    }
    
    func saveItem() {
        do {
            try context.save()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
            self.dismiss(animated: true, completion: nil)
        } catch {
           print("error saving context")
        }
    }
    
    @objc func backTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dateDoneClicked(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
        timeSince1970 = self.datePicker!.date.timeIntervalSince1970
    }
    
    
    @IBAction func addNewSituationPressed(_ sender: UIButton) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Situation", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add Situation", style: .default) { [self] (action) in
            //what will happen once user clicks add
            self.situationTextField.text = textField.text
            
            //create core data object
            let newSituation = Situation(context: context)
            newSituation.place = textField.text
            do {
                try context.save()
                fetchSituationData()
            } catch {
                
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Workdesk"
            textField = alertTextField
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func submitIncidentPressed(_ sender: UIButton) {
        createIncident()
    }
    
    

}

extension NewEntryVC: UITextFieldDelegate {
    
}

extension NewEntryVC: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if pickerView == situationPicker {
            return situations[row].place
        }else if pickerView == affectedAreaPicker {
            return affectedAreas[row]
        }
        return ""
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == situationPicker {
            selectedSituation = situations[row].place!
            situationTextField.text = selectedSituation
        }else if pickerView == affectedAreaPicker {
            selectedArea = affectedAreas[row]
            affectedAreasTextField.text = selectedArea
        } else {
            selectedSituation = ""
        }
       
    }
    
   
    
}

extension NewEntryVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     
        if pickerView == situationPicker {
            return situations.count
        } else if pickerView == affectedAreaPicker {
            return affectedAreas.count
        } else {
            return 0
        }
        
       
    }
    
    
}
