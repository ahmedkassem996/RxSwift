//
//  SectionModel.swift
//  LearningRxSwift
//
//  Created by Nada on 10/15/21.
//  Copyright © 2021 AhmedKassem. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionModel {
    var header: String?
    var items: [Food]
}

extension SectionModel: SectionModelType {
    init(original: SectionModel, items: [Food]) {
        self = original
        self.items = items
    }
}
