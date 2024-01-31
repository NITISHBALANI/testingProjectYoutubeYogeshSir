//
//  ImageItem.swift
//  ShareSheetExtension
//
//  Created by mac on 31/01/24.
//

import SwiftUI
import SwiftData

@Model
class ImageItem {
    @Attribute(.externalStorage)
    var data: Data
    
    init(data: Data) {
        self.data = data
    }
}
