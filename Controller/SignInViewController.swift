//
//  SignInViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Variables
    var networkManager = URLSessionAPIService()
    var arrayDict = [[String: Any]]()
    var categoryNames = [String]()

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Actions
    @IBAction func switchToSignUpTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // instantiating the *SignUpViewController*
        let controller = storyBoard.instantiateViewController(withIdentifier: "signUpVC") as! SignUpViewController
        self.present(controller, animated: false, completion: nil)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        networkManager.postAuth()
        networkManager.getInfoInCategory() { result in
            self.arrayDict = result
        }
        networkManager.getCategoryNames() { result in
            self.categoryNames = result
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            print("arrayDict: \(self.arrayDict)")
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyBoard.instantiateViewController(withIdentifier: "mainViewC") as! MainViewController
            controller.cardItems = self.arrayDict
            controller.categories = self.categoryNames
            self.present(controller, animated: true, completion: nil)
        })
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        keyboardListenEvents()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Functions
    func keyboardListenEvents() {
        // listen for keyboard notifications
        emailTextField.delegate = self
        passwordTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillHideNotification {
            view.frame.origin.y = -(keyboardRect.height - 50)
        } else {
            view.frame.origin.y = 0
        }
    }
}
