//
//  ViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit
import CoreData
var postIDD: Int!

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    var journals: [Entity]!

    
    
    @IBAction func updateJournal(_ sender: UIButton) {
        //TODO 帶值過去下一個Ｖc // 並改變button title
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as? JournalViewController
        
        postIDD = Int(journals[sender.tag].id)
        // print(journals[indexPath.row].content)
        //print(JournalVC.journalContent.text)
        
        self.present(JournalVC!, animated: true, completion: nil)
        
        
        
    }

    @IBAction func addJournal(_ sender: UIButton) {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as? JournalViewController
        self.present(JournalVC!, animated: true, completion: nil)

    }

    @IBOutlet weak var journalList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPostID()
        getCoredata()
         NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

    }

    func loadList(notification: NSNotification) {

        getCoredata()
        //self.journalList.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return journals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as? JournalTableViewCell

//        cell.journalImage.image = UI
        cell?.journalTitle.text = journals[indexPath.row].title
        cell?.postId.text = String(journals[indexPath.row].id)
        cell?.journalImage.image = UIImage(data:(journals[indexPath.row].photo as? Data)!)
        cell?.button.tag = indexPath.row
        
        return cell!
    }

    func tableView(_ tableView: UITableView, editActionsForRowAtIndexPath indexPath: IndexPath) -> [AnyObject]? {
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            print("more button tapped")
        }
        delete.backgroundColor = UIColor.red

        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as? JournalViewController

         postIDD = Int(journals[indexPath.row].id)
       // print(journals[indexPath.row].content)
        //print(JournalVC.journalContent.text)

        self.present(JournalVC!, animated: true, completion: nil)

    }

    func checkPostID () {
        guard UserDefaults.standard.object(forKey: "PostID") != nil else {
            UserDefaults.standard.setValue(0, forKey: "PostID")
            return
        }
    }

    func getCoredata () {

        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let request: NSFetchRequest<Entity> = Entity.fetchRequest()

            let context = appDelegate.persistentContainer.viewContext
            do {
                journals = try context.fetch(request)
            } catch {
             print(error)
            }
            self.journalList.reloadData()
        }
    }
    func manager(didGet journalInfo: Entity) {

    }

}

extension ViewController: infoManagerDelegate {

    class InfoManager {

            weak var delegate: infoManagerDelegate?

            func getcontroller (journalInfo: Entity) {
                DispatchQueue.main.async {
                self.delegate?.manager(didGet: journalInfo)
                }
            }

      }

}
