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

class TableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
