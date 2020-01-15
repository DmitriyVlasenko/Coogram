//
//  PostCreationManager.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 11.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
 class PostCreationManager {
    static var shared = PostModel()
    private init() {}
}
extension PostCreationManager: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
