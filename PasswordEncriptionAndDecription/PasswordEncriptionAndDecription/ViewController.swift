//
//  ViewController.swift
//  PasswordEncriptionAndDecription
//
//  Created by Sunil on 31/01/19.
//  Copyright © 2019 SunilReddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textFieldPassword: UITextField!
    let userDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func encryptButtonPressed(_ sender: Any) {
        if textFieldPassword.text?.count == 0 {
            showAlert(message: "Please enter password")
        }else {

            let keyArch = NSKeyedArchiver.init(requiringSecureCoding: true)
            keyArch.encode(textFieldPassword.text!, forKey: "password")
            let dataVal = keyArch.encodedData
            keyArch.finishEncoding()

            userDefaults.set(dataVal, forKey: "PasswordData")
            userDefaults.synchronize()

            textFieldPassword.text? = "\(dataVal)"

            showAlert(message: "Encrypted password is...\(dataVal)")
        }

    }
    
    @IBAction func decryptButtonPressed(_ sender: Any) {

        do {
              let keyUnArchiver = try NSKeyedUnarchiver.init(forReadingFrom: userDefaults.data(forKey: "PasswordData")!)
            let decryptedValue = keyUnArchiver.decodeObject(forKey: "password")
            showAlert(message: "Decrypted password is...\(decryptedValue!)")
            textFieldPassword.text? = "\(decryptedValue!)"

        } catch  {

        }


    }

    func showAlert(message : String)  {
        let alertViewController = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alertViewController.addAction(okAction)
        self.present(alertViewController, animated: true, completion: nil)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

