//
//  IngridientsCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 09.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class IngridientsCell : UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return title[row]
    }
    @IBOutlet weak var ingridientName: UITextField!
    @IBOutlet weak var ingridientCount: UITextField!
    var title : [String] = []
    @IBOutlet weak var ingridientsPicker: UIPickerView!
    func build(title : [String]){ 
        ingridientsPicker.delegate = self
        ingridientsPicker.dataSource = self
        self.title = title
    }
}
