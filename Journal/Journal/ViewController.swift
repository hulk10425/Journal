//
//  ViewController.swift
//  Journal
//
//  Created by 陳遵丞 on 2017/8/4.
//  Copyright © 2017年 hulk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBAction func updateJournal(_ sender: UIButton) {
        //帶值過去下一個ＶＣ
    }
    
    @IBAction func addJournal(_ sender: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let JournalVC = sb.instantiateViewController(withIdentifier: "JournalVC") as! JournalViewController
        self.present(JournalVC, animated: true, completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkPostID()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalTableViewCell
        return cell
    }
    
    func checkPostID () {
        guard UserDefaults.standard.object(forKey: "PostID") != nil else {
            UserDefaults.standard.setValue(0, forKey: "PostID")
            return
        }
    }

}

