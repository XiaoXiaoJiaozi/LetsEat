//
//  HomeController.swift
//  LetsEat
//
//  Created by Lucy on 12/13/20.
//

import UIKit

import CoreData

class HomeController: UIViewController {
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var dinerdb:NSManagedObject!

    @IBAction func btnSpin(_ sender: UIButton) {
        showAlert()
    }

    // Chooses and displays a randomly chosen restaurant in an alert.
    func showAlert() {
        // Create an empty array to hold restaurant choices.
        var restaurants = [String]()

        // Create a request for CoreData.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Diner")

        do {
            // Fetch objects from CoreData.
            let results = try managedObjectContext.fetch(fetchRequest)
            let diners = results as! [Diner]

            // For each diner object in diners get the restaurants.
            for diner in diners {
                restaurants.append(diner.choiceone!)
                restaurants.append(diner.choicetwo!)
            }
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }

        // Choose a random restaurant.
        let choice = restaurants.randomElement()
        
        // Create an alert for the choice.
        let alert = UIAlertController(title: "You are going to", message: choice, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))

        // Display the alert.
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
}
