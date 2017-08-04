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
        return cell!
    }

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {

        let delete = UITableViewRowAction(style: .normal, title: "More", handler: { (_, _) in print("deleye")
            tableView.isEditing = false
        })

        delete.backgroundColor = UIColor.lightGray

        return [delete]
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // 要显示自定义的action,cell必须处于编辑状态
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // 同时你也需要实现本方法,否则自定义action是不会显示的,啦啦啦
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
