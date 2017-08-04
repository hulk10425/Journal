//
//  JournalViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit
import CoreData

class JournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, infoManagerDelegate {
    let imagePicker = UIImagePickerController()
    var journal: Entity!
    var fetchResultController: NSFetchedResultsController<Entity>!
    var updateJournal: Entity!
    weak var delegate = UIApplication.shared.delegate as? AppDelegate
    
    func manager(didGet journalInfo: Entity) {
        journalContent.text = journalInfo.content
        
    }

    @IBAction func backtoHome(_ sender: UIButton) {
       
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
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
                journal.id = Int16(Int32(UserDefaults.standard.object(forKey: "PostID") as! Int))
                
                if let journalImage = journalPhotoView.image {
                    if let imageData = UIImagePNGRepresentation(journalImage){
                        journal.photo = NSData(data: imageData)
                    }
                }
                
                

                print("saving successed")
                appDelegate.saveContext()
                  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                
                self.dismiss(animated: true, completion: nil)
            }
        } else if sendButton.titleLabel!.text! == "Update" {
            print("hello")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            updateJournal.title = journalTitle.text
            updateJournal.content = journalContent.text
            let imageData: NSData = UIImagePNGRepresentation(journalPhotoView.image!)! as NSData
            updateJournal.photo = imageData
            appDelegate.saveContext()
               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            
            self.dismiss(animated: true, completion: nil)

        }
        
          NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var journalContent: UITextView!
    @IBOutlet weak var journalTitle: UITextField!
    @IBOutlet weak var journalPhotoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if postIDD != nil {
        //journalPhotoView.contentMode = .scaleAspectFill
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let context = appDelegate.persistentContainer.viewContext
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Entity")
        do {
            
            let content = try context.fetch(fetchRequest)
            for journalinfo  in content {
                let container = journalinfo as! Entity
                if Int(container.id) == postIDD {
                    updateJournal = container
                }
                
            }
            
            journalContent.text = updateJournal.content
            journalTitle.text = updateJournal.title
            journalPhotoView.image = UIImage(data:updateJournal.photo as! Data)
            sendButton.setTitle("Update", for: .normal)
            postIDD = nil
        } catch {
            print(error)
        }
        } else {
            sendButton.setTitle("Save", for: .normal)
        }
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
