//
//  ItemDataModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

struct ItemDataModel: Codable, Identifiable {
    var id: Int
    var prod_name: String
    var prod_image: String
    var prod_price: Double
    //var item_description: String
}


//Image(systemName: "square.and.pencil.circle.fill")
//var sampleItemData = [ItemDataModel(imageName: "item2", price: 10.00, name: "test1"),
//                          ItemDataModel(imageName: "item2", price: 20.45, name: "test2"),
//                          ItemDataModel(imageName: "item2", price: 30.7, name: "test3"),
//                          ItemDataModel(imageName: "item2", price: 40.9, name: "test4"),
//                          ItemDataModel(imageName: "item2", price: 60.3, name: "test5")]
