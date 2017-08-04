//
//  ViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    var journals:[Entity]!
    
    
    @IBAction func updateJournal(_ sender: UIButton) {
        //TODO 帶值過去下一個Ｖc // 並改變button title
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as! JournalViewController
        self.present(JournalVC, animated: true, completion: nil)
    }
    
    @IBAction func addJournal(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as! JournalViewController
        self.present(JournalVC, animated: true, completion: nil)
        
    }

    
    @IBOutlet weak var journalList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPostID()
        getCoredata()
    }
    //TODO
    override func viewWillAppear(_ animated: Bool) {
        self.journalList.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return journals.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalTableViewCell
        
//        cell.journalImage.image = UI
        cell.journalTitle.text = journals[indexPath.row].title
        cell.postId.text = String(journals[indexPath.row].id)
        cell.journalImage.image = UIImage(data:journals[indexPath.row].photo as! Data)
        return cell
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
            do{
                journals = try context.fetch(request)
            } catch {
             print(error)
            }
            self.journalList.reloadData()
        }
    }

}

