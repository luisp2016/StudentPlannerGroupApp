//
//  LogInViewController.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit
import CoreData

class LogInViewController: UIViewController {

    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordInput.text = ""
        emailInput.text = ""
    }
    
    @IBAction func login(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Check for blank fields
        if emailInput.text?.count == 0 || passwordInput.text?.count == 0 {
            let alertController = UIAlertController(title: "Invalid Input",
                                                    message: "Please try entering your data again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        }
        
        // Check to see if it exists
        let accountRequest: NSFetchRequest<Account> = Account.fetchRequest()
        accountRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", emailInput.text!, passwordInput.text!)
        if let accountObject = try! context.fetch(accountRequest).first {
            let alertController = UIAlertController(title: "Log In Successful",
                                                    message: "",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                // self.navigationController?.popViewController(animated: true)
                // SET GLOBAL USER VARIABLE!
                globalUserID = accountObject.userID
                self.performSegue(withIdentifier: "goToHomeScreen", sender: nil)
            }))
            
            self.present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Log In Failed",
                                                    message: "Account not found.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                //self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        }
    }
}
