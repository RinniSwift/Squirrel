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
    var modelData = ModelData()

    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Actions
    @IBAction func switchToSignUpTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // instantiating the *SignUpViewController*
        let controller = storyBoard.instantiateViewController(withIdentifier: "signUpVC") as! SignUpViewController
        self.present(controller, animated: false, completion: nil)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if emailTextField.text == "" && passwordTextField.text == "" {
            passwordTextField.redOutline()
            emailTextField.redOutline()
            shakeTextField(textfield: emailTextField)
            shakeTextField(textfield: passwordTextField)
        } else if passwordTextField.text == "" {
            passwordTextField.redOutline()
            shakeTextField(textfield: passwordTextField)
        } else if emailTextField.text == "" {
            emailTextField.redOutline()
            shakeTextField(textfield: emailTextField)
            
        } else {    // VALID USER
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            networkManager.postAuth(username: emailTextField.text!, password: passwordTextField.text!)
            
            networkManager.getCategoryNames() { result in
                self.modelData.modelCategoryNames = result
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                for catName in self.modelData.modelCategoryNames! {
                    self.networkManager.getCategoryInfo(categoryPath: catName) { result in
                        self.modelData.totalCategoryInfo[catName] = result[catName]
                    }
                }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6), execute: {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "mainViewC") as! MainViewController
                controller.totCatinfo = self.modelData.totalCategoryInfo
                controller.categories = self.modelData.modelCategoryNames
                self.present(controller, animated: true, completion: nil)
            })
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientView(colorOne: .smoothBlueBG, colorTwo: .smoothWhiteBG)
        keyboardListenEvents()
        constraintActivityIndic()
        
        activityIndicator.isHidden = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func constraintActivityIndic() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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


extension SignInViewController {
    func shakeTextField(textfield: UITextField) {
        let animation = CABasicAnimation(keyPath: "shake")
        animation.duration = 0.08
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textfield.center.x - 4, y: textfield.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textfield.center.x + 4, y: textfield.center.y))
        textfield.layer.add(animation, forKey: "shake")
    }
}
