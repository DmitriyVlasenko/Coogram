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
    var cellscount = 1
    var collectionOfCells : Set<IngridientsCell> = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var ingridientsTableView: UITableView!
    
    @IBAction func AddIngridient(_ sender: UIButton) {
        cellscount += 1
        ingridientsTableView.reloadData()
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        PostCreationManager.shared.ingridients? = []
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func NextButtonTapped(_ sender: UIButton) {
        collectionOfCells.forEach { (cell) in
            PostCreationManager.shared.ingridients?.append(ingridient(name: cell.ingridientName.text, count: cell.ingridientCount.text, typeOfCounting: cell.selectedPicker))
        }
        let vc = self.storyboard!.instantiateViewController(identifier: "StepsInReceiptViewController")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension IngridientsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsCell
        cell.build(title: pickerdata)
        collectionOfCells.insert(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellscount
    }
}
extension IngridientsViewController : UITextFieldDelegate {

}
