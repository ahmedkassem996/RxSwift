//
//  ViewController.swift
//  LearningRxSwift
//
//  Created by Nada on 10/12/21.
//  Copyright © 2021 AhmedKassem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let items = ["item1", "item2", "item3"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
}
