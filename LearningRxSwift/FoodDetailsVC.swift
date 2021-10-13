//
//  FoodDetailsVC.swift
//  LearningRxSwift
//
//  Created by Nada on 10/13/21.
//  Copyright © 2021 AhmedKassem. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FoodDetailsVC: UIViewController {
    
//    var foodName: String?
    let disposeBag = DisposeBag()
    let imageName = BehaviorRelay<String>(value: "")

    @IBOutlet weak var foodImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageName
            .map ({
            name in
                UIImage.init(named: name)
        })
        .bind(to: foodImg
            .rx
            .image).disposed(by: disposeBag)
    }

}
