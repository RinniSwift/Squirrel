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
        self.dismiss(animated: true, completion: nil)
        guard titleTextField.text != nil, linkTextField.text != nil, notesTextView.text != nil, imageArray != nil else {
            print("cant save // raise error")
            return
        }
        // turn image to string
        // grab category name
        networkManager.postNewCard(name: titleTextField.text!, urll: linkTextField.text!, notes: notesTextView.text!, category: categoryName!, image: "https://p7011128.vo.llnwd.net/e1/wp-content/uploads/plants/originals/10341.jpg")
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
