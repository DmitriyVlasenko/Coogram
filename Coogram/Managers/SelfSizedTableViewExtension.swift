//
//  SelfSizedTableViewExtension.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 22.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {
  var maxHeight: CGFloat = UIScreen.main.bounds.size.height
  
  override func reloadData() {
    super.reloadData()
    self.invalidateIntrinsicContentSize()
    self.layoutIfNeeded()
  }
  
  override var intrinsicContentSize: CGSize {
    let height = min(contentSize.height, maxHeight)
    return CGSize(width: contentSize.width, height: height)
  }
}
