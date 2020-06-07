//
//  ViewController.swift
//  MemeMe1.0
//
//  Created by Hussein Obeid on 2020-03-05.
//  Copyright © 2020 Hussein Obeid. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    struct meme {
        
        var topTextField: String
        var bottomTextField: String
        var firstImage: UIImage
        var memedImage: UIImage
        }
    
    

    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
   
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBAction func shareMemeButton(_ sender: Any) {
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
         subscribeToKeyboardNotifications()
        
         self.topTextField.adjustsFontSizeToFitWidth = true
        self.topTextField.minimumFontSize = 11.0
        self.bottomTextField.adjustsFontSizeToFitWidth = true
        self.bottomTextField.minimumFontSize = 11.0
}
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         unsubscribeFromKeyboardNotifications()
        
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField(topTextField, defaultText: "TOP")
        setupTextField(bottomTextField, defaultText: "BOTTOM")
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
       
        
    }
    
    
    // Keyboard Application
        
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
        
    }
    
        func getKeyboardHeight(_ notification:Notification) -> CGFloat {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            return keyboardSize.cgRectValue.height
    }
    
        func subscribeToKeyboardNotifications() {

            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

        func unsubscribeFromKeyboardNotifications() {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
        func subscribeToKeyboardNotificationsWillHide() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotificationsWillHide() {
         
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    // textField setup
        
        func setupTextField(_ textField: UITextField, defaultText: String) {
            textField.text = defaultText
            textField.textAlignment = .center
            textField.defaultTextAttributes = memeTextAttributes
            textField.delegate = self
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            topTextField.resignFirstResponder()
            bottomTextField.resignFirstResponder()
            return true
            
        }
        
    func textFieldDidBeginEditing(_textField: UITextField) {
            topTextField.text = ""
            bottomTextField.text = ""
        }
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont (name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: 3
        ]
        
        // Do any additional setup after loading the view.
    

    @IBAction func pickAnImage(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        
         let pickerController = UIImagePickerController()
             pickerController.delegate = self
             pickerController.sourceType = .camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
        present(pickerController, animated: true, completion: nil)
       
               
    }
    
    // Loading imagePickerController
    
    func imagePickerController(_:UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imagePickerView.image = image
            
        } else if let  image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        
    }
            
            
            dismiss(animated: true, completion: nil)
        
        func imagePickerControllerDidCancel(_ :UIImagePickerController) {
            dismiss(animated: true, completion: nil)
            
        }
    
       // Meme Editor / Generator
        

       
        
    func generateMemedImage() -> UIImage {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.setToolbarHidden(true, animated: false)

        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
       
        return memedImage
        
        }
        
    
         let items = [imagePickerView]
        
        
        UIActivityViewController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) -> Void in
        if completed {
            self.save()
    }

        func save() {
                  
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
            
    }
        

        
        
        
        
            
            
    
}
}
}
}
