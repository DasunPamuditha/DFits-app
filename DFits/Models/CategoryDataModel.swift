//
//  CategoryDataModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-30.
//

import Foundation
import SwiftUI

struct CategoryDataModel: Codable, Identifiable {
    var id = UUID()
    var prod_category: String
}
