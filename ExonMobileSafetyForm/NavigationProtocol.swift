//
//  NavigationProtocol.swift
//  ExonMobileSafetyForm
//
//  Created by Salman Fakhri on 2/24/18.
//  Copyright © 2018 Salman Fakhri. All rights reserved.
//

import Foundation
import UIKit

enum Destinations {
    case formView
    case tableView
}

protocol NavigationProtocol {
    
}

extension NavigationProtocol {
    func performNavigation(currentView: UIViewController, destination: Destinations)  {
        switch destination {
        case .formView:
            currentView.performSegue(withIdentifier: "goToForm", sender: currentView)
        case .tableView:
            print("performing table view segue")
            currentView.performSegue(withIdentifier: "goToTableView", sender: currentView)
        default:
            print("default case")
        }
    }
    
    func prepareForNavigation(currentView: UIViewController, destination: Destinations, segue: UIStoryboardSegue, sender: Any?) {
        switch destination {
        case .formView:
            if let nextView = segue.destination as? FormViewController {
                
                nextView.formImage = sender as! UIImage
            }
        case .tableView:
            print("performing table view segue")
            if let nextView = segue.destination as? TableViewController {
                
            }
        default:
            print("default case")
        }
    }
}
