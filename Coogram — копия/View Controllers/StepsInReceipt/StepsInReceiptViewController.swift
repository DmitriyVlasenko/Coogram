//
//  StepsInReceiptViewController.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 11.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
final class StepsInReceiptViewController: UIViewController {
    var stepscount = 1
    override func viewDidLoad() {
    super.viewDidLoad()
    
    }

    @IBOutlet weak var StepsTableView: UITableView!
    
    @IBAction func AddStepButtonTapped(_ sender: UIButton) {
        stepscount += 1
        StepsTableView.reloadData()
        

    }
    @IBAction func PostButtonTapped(_ sender: UIButton) {
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func BackButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension StepsInReceiptViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stepscount
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Шаг \(section + 1)"
    }
}
extension StepsInReceiptViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepsInReceiptCell", for: indexPath) as! StepsInReceiptCell
        cell.build(presentingvc: self)
        return cell
    }
    
    
}

