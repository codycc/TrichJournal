//
//  ReflectVC.swift
//  TrichJournal
//
//  Created by Cody Condon on 2025-01-28.
//

import UIKit
import DGCharts
import CoreData

class ReflectVC: UIViewController {

    @IBOutlet weak var dataLbl: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var reflectLbl: UILabel!
    
    @IBOutlet weak var cycleBtn: UIImageView!
    
    @IBOutlet weak var backBtn: UIImageView!
    
    
    var entriesArray = [Incident]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedData = 1
    
    
    
    let requestIncident = NSFetchRequest<NSFetchRequestResult>(entityName: "Incident")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cycleTap = UITapGestureRecognizer(target: self, action: #selector(self.cycleTapped(_:)))
        cycleBtn.addGestureRecognizer(cycleTap)

        reflectLbl.font = UIFont(name:"Roboto-SemiBold",size:30)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(self.backTapped(_:)))
        backBtn.addGestureRecognizer(backTap)
        
        fetchEntries()
        updateChart()
       
    }
    
    func fetchEntries() {
        entriesArray = []
        do {
            let results = try context.fetch(requestIncident)
            if results.count > 0 {
                for result in results {
                    entriesArray.append(result as! Incident)

                }
            }
        } catch {
            // handle error
        }
    }
    
    func updateChart(){
        //MAKE DECISION ON WHICH FUNCTION TO CALL
        switch selectedData {
        case 1:
            showArea()
            dataLbl.text = "Area Affected"
        case 2:
            showLength()
            dataLbl.text = "Length(Minutes)"
        case 3:
            showDigested()
            dataLbl.text = "Did You Digest?"
        case 4:
            showNumOfHairs()
            dataLbl.text = "Number Of Hairs"
        case 5:
            showSituation()
            dataLbl.text = "Situation"
        case 6:
            showIntensity()
            dataLbl.text = "Intensity"
        default:
            print("default")
            
        }
        
        ///
     //   pieChartView.chartDescription?.text = ""
        pieChartView.chartDescription.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pieChartView.legend.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pieChartView.animate(yAxisDuration: 1.0)
        pieChartView.notifyDataSetChanged()
    }
    
    
    func showSituation() {
        var counts: [String: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.situation!] = (counts[entry.situation!] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: entry.key)
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    
    func showIntensity() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.intensity] = (counts[entry.intensity] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: (Double(entry.value) ), label: String("\(entry.key) / 10"))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showLength() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.howLong] = (counts[entry.howLong] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        
        //SAVE THIS FOR TOMORROW
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String("\(entry.key) Minutes "))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showDigested() {
        var counts: [String: Int32] = [:]
        var didYouDigest = ""
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in entriesArray {
            if entry.didYouDigest == true {
                didYouDigest = "Yes"
            } else {
                didYouDigest = "No"
            }
            
            counts[didYouDigest] = (counts[didYouDigest] ?? 0) + 1
        }

        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: entry.key)
            lineChartEntry.append(value)
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
        
    }
    
    func showNumOfHairs() {
        var counts: [Int32: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.numberOfHairsPulled] = (counts[entry.numberOfHairsPulled] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String("\(entry.key) Hairs "))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
    }
    
    func showArea() {
        var counts: [String: Int32] = [:]
        
        for entry in entriesArray {
            counts[entry.areaAffected!] = (counts[entry.areaAffected!] ?? 0) + 1
        }
        
        var lineChartEntry = [ChartDataEntry]()
        
        for entry in counts {
            let value = PieChartDataEntry(value: Double(entry.value), label: String(entry.key))
            lineChartEntry.append(value)
            
        }
        
        let dataSet = PieChartDataSet(entries: lineChartEntry, label: "")
        dataSet.colors = ChartColorTemplates.liberty()
        dataSet.entryLabelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        
        let data = PieChartData(dataSets: [dataSet])
        data.setValueTextColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        pieChartView.data = data
    }
    
    
    @objc func cycleTapped(_ sender: UITapGestureRecognizer? = nil) {
        selectedData += 1
        updateChart()
        if selectedData == 6 {
            selectedData = 0
        }
        
    }
    
    
    @objc func backTapped(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
        

}
