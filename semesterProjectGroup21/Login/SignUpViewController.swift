//
//  SignInViewController.swift
//  semesterProjectGroup21
//
//  Created by Isiah Manns on 5/13/19.
//  Copyright © 2019 Group 21. All rights reserved.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordInput.text = ""
        emailInput.text = ""
    }
    
    @IBAction func signUp(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Check for blank fields
        if emailInput.text?.count == 0 || passwordInput.text?.count == 0 {
            let alertController = UIAlertController(title: "Invalid Input",
                                                    message: "Please try entering your data again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                //self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        }
        
        // Check to see if it exists
        let accountRequest: NSFetchRequest<Account> = Account.fetchRequest()
        accountRequest.predicate = NSPredicate(format: "email == %@", emailInput.text!)
        if let _ = try! context.fetch(accountRequest).first {
            let alertController = UIAlertController(title: "Duplicate Email",
                                                    message: "Please try entering your data again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                //self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        }

        // Validate input
        // Save to database
        if isValidEmail(testStr: emailInput.text!) {
            let account = Account(context: context)
            account.email = emailInput.text!
            account.password = passwordInput.text!
            
            let userIDRequest: NSFetchRequest<Student> = Student.fetchRequest()
            account.userID = try! Int16(context.fetch(userIDRequest).count)
            
            let student = Student(context: context)
            student.userID = account.userID
            
            // Save object
            do {
                try context.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            // Show alert, then navigate back to login screen
            let alertController = UIAlertController(title: "Account Created",
                                                    message: "Your account has been created succesfully. Please log in.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        } else {
            // Show alert, then navigate back to login screen
            let alertController = UIAlertController(title: "Invalid E-mail Address",
                                                    message: "Please try entering your data again.",
                                                    preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
                //self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alertController, animated: true)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
