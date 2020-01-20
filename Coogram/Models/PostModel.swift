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
    var count : String?
    var typeOfCounting: String?
    var position : Int?
    
}
struct descriptionStep {
    var image : UIImage?
    var description : String?
    var imageURL : String?
    var step : Int?
}
struct PostModel {
    var user: String?
    var mainImage : UIImage?
    var receiptName : String?
    var properties : [String]? = []
    var description : String?
    var hours : String?
    var minutes : String?
    var calories : String?
    var ingridients: [ingridient]? = []
    var descriptionSteps: [descriptionStep]? = []
    var creationDate : TimeInterval?
    var mainImageUrl : String?
}
