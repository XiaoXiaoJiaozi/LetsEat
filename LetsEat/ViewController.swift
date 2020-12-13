//
//  ViewController.swift
//  LetsEat
//
//  Created by Lucy on 11/16/20.
//

import UIKit

import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var dinername: UITextField!
    @IBOutlet weak var choiceone: UITextField!
    @IBOutlet weak var choicetwo: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnSave(_ sender: AnyObject) {
        //1 Add Save Logic
        if (dinerdb != nil) {
            
            dinerdb.setValue(dinername.text, forKey: "dinername")
            dinerdb.setValue(choiceone.text, forKey: "choiceone")
            dinerdb.setValue(choicetwo.text, forKey: "choicetwo")
            
        } else {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Diner",in: managedObjectContext)
            
            let diner = Diner(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            diner.dinername = dinername.text!
            diner.choiceone = choiceone.text!
            diner.choicetwo = choicetwo.text!
        }
        
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
           // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        dinername.isEnabled = true
        choiceone.isEnabled = true
        choicetwo.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        dinername.becomeFirstResponder()
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        //2) Dismiss ViewController
       self.dismiss(animated: true, completion: nil)
//       let detailVC = DinerTableViewController()
//        detailVC.modalPresentationStyle = .fullScreen
//        present(detailVC, animated: false)
    }
    
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    //4) Add variable contactdb (used from UITableView
    var dinerdb:NSManagedObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
        
        if (dinerdb != nil) {
            dinername.text = dinerdb.value(forKey: "dinername") as? String
            choiceone.text = dinerdb.value(forKey: "choiceone") as? String
            choicetwo.text = dinerdb.value(forKey: "choicetwo") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            dinername.isEnabled = false
            choiceone.isEnabled = false
            choicetwo.isEnabled = false
            btnSave.isHidden = true
        } else {
          
            btnEdit.isHidden = true
            dinername.isEnabled = true
            choiceone.isEnabled = true
            choicetwo.isEnabled = true
        }
        
        dinername.becomeFirstResponder()
        // Do any additional setup after loading the view.
        
        // Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //6 Add to hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }

    //7 Add to hide keyboard
    
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        dinername.endEditing(true)
        choiceone.endEditing(true)
        choicetwo.endEditing(true)
        
    }
    
    //8 Add to hide keyboard
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
