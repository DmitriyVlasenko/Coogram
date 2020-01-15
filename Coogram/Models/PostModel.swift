//
//  postModel.swift
//  Coogram
//
//  Created by Дмитрий Власенко on 08.01.2020.
//  Copyright © 2020 Дмитрий Власенко. All rights reserved.
//

import UIKit
struct ingridient {
    var name : String?
    var count : Int?
    var typeOfCounting: String?
}
struct descriptionStep {
    var image : UIImage?
    var description : String
}
struct PostModel {
    
    var mainImage : UIImage?
    var receiptName : String?
    var properties : [properties]?
    var description : String?
    var cookingTime : [Int]?
    var calories : Int?
    var ingridients: [ingridient]?
    var descriptiomSteps: [descriptionStep]?
    var imagesUrl : [URL]?
    var date : Date?
}
