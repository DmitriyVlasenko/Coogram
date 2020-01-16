//
//  Properties.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 04.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
struct property {
    let checkboxlabel : String
    var isSelected : Bool = false
}
struct properties {
    let sectionTitle : String
    var properties : [property]
}

