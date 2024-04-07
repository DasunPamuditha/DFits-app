//
//  HomeViewModel.swift
//  DFits
//
//  Created by Dasun Pamuditha on 2024-03-24.
//

import Foundation
import SwiftUI

class HomeViewModel : ObservableObject{
    @Published var searchString : String = ""
    @Published var categoryData = sampleCategoryData
}
