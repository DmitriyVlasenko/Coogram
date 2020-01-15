//
//  SelectPropertiesCell.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 04.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit

final class SelectPropertiesCell: UITableViewCell {
    @IBOutlet weak var SelectPropertiesButton: UIButton!
    
    @IBOutlet weak var propertiesLabel: UILabel!
    var row : Int = 0
    var section : Int = 0
    func buildCell(text: String, isSelected : Bool) {
        self.propertiesLabel.text = text
        if isSelected {
            self.SelectPropertiesButton.tintColor = .red
            self.SelectPropertiesButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle.fill"), for: UIControl.State())
            self.SelectPropertiesButton.alpha = 0.9
        }
        else {
            self.SelectPropertiesButton.alpha = 0.4
            self.SelectPropertiesButton.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.SelectPropertiesButton.setBackgroundImage(UIImage(systemName: "rectangle"), for: UIControl.State())
        }
    }
    @IBAction func CheckBoxTapped(_ sender: UIButton) {
        for i in 0...RecipePropertiesViewController.propertiesList.count-1{
            for y in 0...RecipePropertiesViewController.propertiesList[i].properties.count-1{
                if RecipePropertiesViewController.propertiesList[i].properties[y].checkboxlabel == self.propertiesLabel.text {
                    self.section = i
                    self.row = y
                    break
                }
            }
        }
        if RecipePropertiesViewController.propertiesList[self.section].properties[self.row].isSelected {
            self.SelectPropertiesButton.alpha = 0.4
            self.SelectPropertiesButton.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.SelectPropertiesButton.setBackgroundImage(UIImage(systemName: "rectangle"), for: UIControl.State())
            RecipePropertiesViewController.propertiesList[self.section].properties[self.row].isSelected = false
        }
        else {
            self.SelectPropertiesButton.tintColor = .red
            self.SelectPropertiesButton.setBackgroundImage(UIImage(systemName: "checkmark.rectangle.fill"), for: UIControl.State())
            self.SelectPropertiesButton.alpha = 0.9
            RecipePropertiesViewController.propertiesList[self.section].properties[self.row].isSelected = true
        }
    }
}
