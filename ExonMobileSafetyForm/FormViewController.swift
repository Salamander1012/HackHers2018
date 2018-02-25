//
//  FormViewController.swift
//  ExonMobileSafetyForm
//
//  Created by Salman Fakhri on 2/24/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import UIKit
import CoreLocation

class FormViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var severitySlider: UISlider!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var locationManager:CLLocationManager!

    
    
    var formImage: UIImage?

    @IBOutlet weak var categoryField: UITextField!
    
    var dismissKeyboardGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgImageView.image = formImage
        formView.layer.opacity = 0.85
        
        categoryField.attributedPlaceholder = NSAttributedString(string: "Category e.g. \"Roof leak\"", attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        
        dismissKeyboardGestureRecognizer.numberOfTapsRequired = 1
        
        dismissKeyboardGestureRecognizer.addTarget(self, action: #selector(handleKeyboard))
        view.addGestureRecognizer(dismissKeyboardGestureRecognizer)
        
        submitButton.layer.cornerRadius = 20
        
        determineMyCurrentLocation()
        
    }
    
    @objc func handleKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func submitEntry(_ sender: Any) {
        handleSubmission()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    func getTodayString() -> String{
        
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
        
    }
    
    func handleSubmission() {
        if(categoryField.hasText && descriptionTextView.hasText) {
            let category = categoryField.text
            let description = descriptionTextView.text
            let severity = severitySlider.value.rounded()
            let obj = SafetyForm(date: getTodayString(),location:"Rutgers University", category: category!, severity: Int(severity), description: description!, picture: formImage!)
            
            forms.append(obj)
            print(obj)
            self.navigationController?.popToRootViewController(animated: true)

        }
        
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
