//
//  FoodDetailsVC.swift
//  LearningRxSwift
//
//  Created by Nada on 10/13/21.
//  Copyright © 2021 AhmedKassem. All rights reserved.
//

import UIKit

class FoodDetailsVC: UIViewController {
    
    var foodName: String?

    @IBOutlet weak var foodImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodImg.image = UIImage.init(named: foodName ?? "")
    }

}
