//
//  HomeDataModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

struct HomeDataModel : Hashable{
    //clothing category data
    var categoryID = UUID().uuidString
    var categoryName : String
    
    
}

var sampleCategoryData = [HomeDataModel(categoryName: "All"),
                          HomeDataModel(categoryName: "Mens"),
                          HomeDataModel(categoryName: "Womens"),
                          HomeDataModel(categoryName: "Kids"),
                          HomeDataModel(categoryName: "Shoes"),
                          HomeDataModel(categoryName: "Sliders")]
