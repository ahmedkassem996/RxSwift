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
import RxDataSources

class ViewController: UIViewController {
    
    let tableViewItemSectioned = BehaviorRelay.init(value: [
        SectionModel(header: "Main Cources", items: [
        Food.init(name: "Food2", image: "food2"),
        Food.init(name: "Food3", image: "food3"),
        Food.init(name: "Food4", image: "food4"),
        Food.init(name: "Food5", image: "food5"),
        ]),
        SectionModel(header: "Desertes", items: [
            Food.init(name: "Food6", image: "food6"),
            Food.init(name: "Food7", image: "food7")
        ])
    ])
    
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel>(configureCell: { (ds, tv, ip, item) -> UITableViewCell in
        let cell: FoodTableViewCell = tv.dequeueReusableCell(withIdentifier: "foodCell", for: ip) as! FoodTableViewCell
        cell.foodName.text = item.name
        cell.foodImg.image = UIImage.init(named: item.image)
        
        return cell
    }, titleForHeaderInSection: {
        ds, index in
        return ds.sectionModels[index].header
    })

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Menu"
        
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "foodCell")
        
        searchBar.rx.text.orEmpty
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({
                query in
                self.tableViewItemSectioned.value.map({
                    sectionModel in
                    SectionModel(header: sectionModel.header, items: sectionModel.items.filter({
                        food in
                        query.isEmpty || food.name.lowercased().contains(query.lowercased())
                    }))
                })
            })
            .bind(to: tableView
            .rx
            .items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
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
