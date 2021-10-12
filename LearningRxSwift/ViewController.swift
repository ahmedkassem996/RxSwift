//
//  ViewController.swift
//  LearningRxSwift
//
//  Created by Nada on 10/12/21.
//  Copyright © 2021 AhmedKassem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    let items = Observable.just(["item1", "item2", "item3"])
        let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        items.bind(to: tableView.rx.items(cellIdentifier: "myCell")) {tv , tableViewItems, cell in
            cell.textLabel?.text = tableViewItems
        }.disposed(by: disposeBag)
    }


}
