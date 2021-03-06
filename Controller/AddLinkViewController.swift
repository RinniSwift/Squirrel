//
//  AddLinkViewController.swift
//  Squirrel
//
//  Created by Rinni Swift on 3/2/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import Photos

class AddLinkViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Variables
    var imageArray = [UIImage]()
    var categoryName: String?
    var imagePicker = UIImagePickerController()
    var networkManager = URLSessionAPIService()

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // TODO: setup UIAlertView when users dont save a url or url is invalid.
        
        if titleTextField.text == "" && linkTextField.text == "" {
            redBorder(textfild: titleTextField)
            redBorder(textfild: linkTextField)
            return
        } else if titleTextField.text == "" {
            redBorder(textfild: titleTextField)
            return
        } else if linkTextField.text == "" {
            redBorder(textfild: linkTextField)
            return
        }
        
        if imageArray.isEmpty {
            let itemAdded = CardInfo(name: titleTextField.text!, notes: notesTextView.text!, url: linkTextField.text!, image: "https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png", category: categoryTitle.text!)
            sendLinkData(item: ["added": itemAdded])
        } else {
            let itemAdded = CardInfo(name: titleTextField.text!, notes: notesTextView.text!, url: linkTextField.text!, image: "https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png ", category: categoryName!)
            sendLinkData(item: ["added": itemAdded])
        }
        
        self.dismiss(animated: true, completion: nil)
        networkManager.postNewCard(name: titleTextField.text!, urll: linkTextField.text!, notes: notesTextView.text!, category: categoryName!, image: "https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png")
    }
    
    
    @objc func sendLinkData(item: [String: CardInfo]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "linkData"), object: nil, userInfo: item)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        openPhotoLibrary()
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        flowLayout()
        imagePicker.delegate = self
        categoryTitle.text = categoryName
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func flowLayout() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = (collectionView.frame.size.width / 2) - 2
        let height = (collectionView.frame.size.width / 2) + 30
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    func openPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imgPicked = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            dismiss(animated: true, completion: nil)
            imageArray.append(imgPicked)
            collectionView.reloadData()
        }
    }
}

extension AddLinkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! AddImageCollectionViewCell
        cell.cellImage.image = imageArray[indexPath.item]
        return cell
    }
    
}

extension AddLinkViewController {
    func redBorder(textfild: UITextField) {
        textfild.layer.borderWidth = 1.0
        textfild.layer.cornerRadius = 5.5
        textfild.layer.borderColor = UIColor.red.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            textfild.layer.borderWidth = 0
        }
    }
}
