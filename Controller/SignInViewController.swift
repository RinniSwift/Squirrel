//
//  SignInViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 2/21/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    var modelData = ModelData()
    
    // MARK: - Variables
    var networkManager = URLSessionAPIService()
    
    // MARK: - Category Items
    var arrayDictMakeSchool = [[String: Any]]()
    var arrayDictFashion = [[String:Any]]()
    var arrayDictCat = [[String: Any]]()
    var categoryNames = [String]()
    var totCat = [String: [[String: Any]]]()

    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardView: UIView!
    
    // MARK: - Actions
    @IBAction func switchToSignUpTapped(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        // instantiating the *SignUpViewController*
        let controller = storyBoard.instantiateViewController(withIdentifier: "signUpVC") as! SignUpViewController
        self.present(controller, animated: false, completion: nil)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if emailTextField.text == "" && passwordTextField.text == "" {
            passwordTextField.layer.cornerRadius = 5.5
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            emailTextField.layer.cornerRadius = 5.5
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            shakeTextField(textfield: emailTextField)
            shakeTextField(textfield: passwordTextField)
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.passwordTextField.layer.borderWidth = 0
                self.emailTextField.layer.borderWidth = 0
            })
        } else if passwordTextField.text == "" {
            passwordTextField.layer.cornerRadius = 5.5
            passwordTextField.layer.borderWidth = 1.0
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            shakeTextField(textfield: passwordTextField)
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.passwordTextField.layer.borderWidth = 0
            })
        } else if emailTextField.text == "" {
            emailTextField.layer.cornerRadius = 5.5
            emailTextField.layer.borderWidth = 1.0
            emailTextField.layer.borderColor = UIColor.red.cgColor
            shakeTextField(textfield: emailTextField)
            
            let deadlineTime = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
                self.emailTextField.layer.borderWidth = 0
            })
        } else {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            networkManager.postAuth(username: emailTextField.text!, password: passwordTextField.text!)
            networkManager.getInfoInCategory() { result in
                self.arrayDictMakeSchool = result
                self.totCat["Make School"] = result
            }
            networkManager.getInfoInNextCategory() { result in
                self.arrayDictFashion = result
                self.totCat["Style"] = result
            }
            networkManager.getInfoInNextNextCategory() { result in
                self.arrayDictFashion = result
                self.totCat["Cat"] = result
            }
            networkManager.getCategoryNames() { result in
                self.categoryNames = result
                self.modelData.modelCategoryNames = result
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                print("arrayDictMakeSchool: \(self.arrayDictMakeSchool)")
                print("arrayDictFashion: \(self.arrayDictFashion)")
                print("arrayDictCat: \(self.arrayDictCat)")
                
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyBoard.instantiateViewController(withIdentifier: "mainViewC") as! MainViewController
                controller.cardItemsMakeSchool = self.arrayDictMakeSchool
                controller.cardItemsFashion = self.arrayDictFashion
                controller.cardItemsCat = self.arrayDictCat
                controller.categories = self.categoryNames
                controller.totCatinfo = self.totCat
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
