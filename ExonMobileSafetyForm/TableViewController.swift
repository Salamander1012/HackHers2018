//
//  TableViewController.swift
//  ExonMobileSafetyForm
//
//  Created by Salman Fakhri on 2/25/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit

var forms: [SafetyForm] = [] {
    didSet {
        for form in forms {
            print(form)
        }
    }
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 140
        tableView.rowHeight = 342
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.categoryLabel.text = forms[indexPath.row].category
        cell.locationLabel.text = forms[indexPath.row].location
        cell.safetyPicture.image = forms[indexPath.row].picture
        cell.timeLabel.text = "Date/time: \n" + forms[indexPath.row].date
        cell.severityLabel.text = "Severity: \(forms[indexPath.row].severity)"
        cell.severityNum = forms[indexPath.row].severity
        cell.descriptionLabel.text = forms[indexPath.row].description
        
        if(cell.severityNum<=3) {
            cell.severityLabel.text = "Severity: Mild"
            cell.severityLabel.textColor = .green
        } else if (cell.severityNum>=7) {
            cell.severityLabel.text = "Severity: Hazardous"
            cell.severityLabel.textColor = .red
        } else {
            cell.severityLabel.text = "Severity: Moderate"
            cell.severityLabel.textColor = .orange
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forms.count
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
