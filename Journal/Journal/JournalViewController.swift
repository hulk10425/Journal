//
//  JournalViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit

class JournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()

    @IBAction func chosePhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var journalContent: UITextView!
    @IBOutlet weak var journalTitle: UILabel!
    @IBOutlet weak var journalPhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self

        // Do any additional setup after loading the view.
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //picker.dismiss(animated: true, completion: nil)
        
    
    if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
        journalPhotoView.image = image
    } else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        journalPhotoView.image = image
    }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


}
