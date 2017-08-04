//
//  JournalViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate {
    let imagePicker = UIImagePickerController()
    var journal: Entity!
    var fetchResultController: NSFetchedResultsController<Entity>!
    weak var delegate = UIApplication.shared.delegate as? AppDelegate

    @IBAction func chosePhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveToCoredata(_ sender: UIButton) {
        if sendButton.titleLabel!.text! == "Save" {
            let postID = UserDefaults.standard.object(forKey: "PostID") as! Int
            UserDefaults.standard.setValue(postID + 1, forKey: "PostID")
            //這裡感覺可以寫成一個func 再去call他
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                journal = Entity(context: appDelegate.persistentContainer.viewContext)
                journal.title = journalTitle.text
                journal.content = journalContent.text
                journal.isdeleted = false
                journal.id = Int32(UserDefaults.standard.object(forKey: "PostID") as! Int)
                
                if let journalImage = journalPhotoView.image {
                    if let imageData = UIImagePNGRepresentation(journalImage){
                        journal.photo = NSData(data: imageData)
                    }
                }
                print("saving successed")
                appDelegate.saveContext()
                
            }
        } else if sendButton.titleLabel!.text! == "Update" {
            
        }
    }
    
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var journalContent: UITextView!
    @IBOutlet weak var journalTitle: UITextField!
    @IBOutlet weak var journalPhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
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
