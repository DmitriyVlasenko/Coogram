//
//  RecipePropertiesViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 03.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
final class RecipePropertiesViewController : UIViewController {
    @IBOutlet weak var propertiesTableView: UITableView!
     static var propertiesList : [properties] =
        [properties(sectionTitle: "Методы приготовления", properties: [property(checkboxlabel: "Нарезать"),property(checkboxlabel: "Взбивать"),property(checkboxlabel: "Варить"),property(checkboxlabel: "Тушить"),property(checkboxlabel: "Гриль"),property(checkboxlabel: "Жарить"),property(checkboxlabel: "Мангал")]),
         properties(sectionTitle: "Тип питания", properties: [property(checkboxlabel: "Любой"),property(checkboxlabel: "Правильное питание"),property(checkboxlabel: "Диабетические рецепты"),property(checkboxlabel: "Низкокалорийные рецепты"),property(checkboxlabel: "Детское питание")]),properties(sectionTitle: "Время приема пищи", properties: [property(checkboxlabel: "Завтрак"),property(checkboxlabel: "Обед"),property(checkboxlabel: "Ужин"),property(checkboxlabel: "Любое")])]
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionTextView.makeBorders()
    }
    @IBOutlet weak var minutesTextField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        for i in 0...RecipePropertiesViewController.propertiesList.count - 1 {
            for y in 0...RecipePropertiesViewController.propertiesList[i].properties.count - 1 {
                print(RecipePropertiesViewController.propertiesList[i].properties[y].isSelected)
                print(RecipePropertiesViewController.propertiesList[i].properties[y].checkboxlabel)
            }
        }
        let vc = self.storyboard!.instantiateViewController(identifier: "IngridientsViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true) {

        }
    }
}
extension RecipePropertiesViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecipePropertiesViewController.propertiesList[section].properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectPropertiesCell", for: indexPath) as! SelectPropertiesCell
        cell.buildCell(text: RecipePropertiesViewController.propertiesList[indexPath.section].properties[indexPath.row].checkboxlabel, isSelected: RecipePropertiesViewController.propertiesList[indexPath.section].properties[indexPath.row].isSelected)
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return RecipePropertiesViewController.propertiesList[section].sectionTitle
    }
    
    
}
extension RecipePropertiesViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return RecipePropertiesViewController.propertiesList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(indexPath.section)
    }
    
}

extension RecipePropertiesViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case hoursTextField:
            if ((textField.text?.count)! + (string.count - range.length)) > 2 {
                return false
            }
        case minutesTextField:
            if ((textField.text?.count)! + (string.count - range.length)) > 2 {
                return false
            }
        case caloriesTextField:
            if ((textField.text?.count)! + (string.count - range.length)) > 4 {
                return false
            }
        default:
            return true
        }
        return true
    }
}
