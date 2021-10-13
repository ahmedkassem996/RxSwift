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
    
    
    let tableViewItems = Observable.just([Food.init(name: "Food1", image: "food1"),
                                         Food.init(name: "Food2", image: "food2"),
                                         Food.init(name: "Food3", image: "food3")])
        let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Menu"
        
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "foodCell")
        
        tableViewItems.bind(to: tableView
            .rx
            .items(cellIdentifier: "foodCell", cellType: FoodTableViewCell.self)) {tv , tableViewItems, cell in
            cell.foodName.text = tableViewItems.name
            cell.foodImg.image = UIImage.init(named: tableViewItems.image)
        }.disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(Food.self)
            .subscribe(onNext: { (foodObject) in
                let foodVc = self.storyboard?.instantiateViewController(identifier: "FoodDetailsVC") as! FoodDetailsVC
                foodVc.imageName.accept(foodObject.image)
                self.navigationController?.pushViewController(foodVc, animated: true)
            }).disposed(by: disposeBag)
        
        // if you need to know indexPath
        tableView
        .rx
        .itemSelected
            .subscribe(onNext: { (indexPath) in
                print(indexPath.row)
            }).disposed(by: disposeBag)
    }

}
