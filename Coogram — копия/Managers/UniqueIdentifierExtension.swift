//
//  UniqueIdentifierExtension.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 14.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
extension UIViewController {
    func makeUniqueID() -> String {
        var hash = String()
        for _ in 0...90 {
            let selector = Int.random(in: 0...1)
            switch selector {
            case 0:
                 hash.append(Character(UnicodeScalar(Int.random(in: 65...90))!)) // A-Z
            case 1:
                hash.append(Character(UnicodeScalar(Int.random(in: 48...57))!)) // 0-9
            default:
                 hash.append(Character(UnicodeScalar(Int.random(in: 65...90))!))
            }
        }
        return hash
    }
    
}
