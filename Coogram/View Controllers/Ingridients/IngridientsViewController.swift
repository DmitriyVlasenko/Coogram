//
//  IngridientsViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 09.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class IngridientsViewController : UIViewController {
    var pickerdata = ["шт","г","кг","мл","л"]
    var model : [IngridientsCellModel] = [IngridientsCellModel()]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var ingridientsTableView: UITableView!
    
    @IBAction func NameTextFieldDidChange(_ sender: UITextField) {
        let cell = sender.superview?.superview as! IngridientsCell
        let indexpath = ingridientsTableView.indexPath(for: cell)
        model[indexpath!.row].ingridientName = sender.text
    }
    @IBAction func CountTextFieldChanged(_ sender: UITextField) {
        let cell = sender.superview?.superview as! IngridientsCell
        let indexpath = ingridientsTableView.indexPath(for: cell)
        model[indexpath!.row].ingridientCount = sender.text
    }
    @IBAction func AddIngridient(_ sender: UIButton) {
        model.append(IngridientsCellModel())
        ingridientsTableView.reloadData()
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        PostCreationManager.shared.ingridients? = []
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        for i in 0...model.count-1 {
            PostCreationManager.shared.ingridients?.append(ingridient(name: model[i].ingridientName, count: model[i].ingridientCount, typeOfCounting: model[i].typeOfCounting, position : i))
        }
        let vc = self.storyboard!.instantiateViewController(identifier: "StepsInReceiptViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension IngridientsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
}

extension IngridientsViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let cell = pickerView.superview?.superview as! IngridientsCell
        let indexpath = ingridientsTableView.indexPath(for: cell)
        model[indexpath!.row].typeOfCounting = pickerdata[row]
    }
}

extension IngridientsViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerdata[row]
    }
    
}
