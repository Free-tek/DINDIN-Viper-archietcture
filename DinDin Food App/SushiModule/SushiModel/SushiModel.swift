//
//  SushiModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct SushiModel {
    let susshiName: String?
    let susshiImage: String?
    let susshiDescription: String?
    let susshiStoreId: String?
    let susshiPrice: Int?

    init(susshiName: String?, susshiImage: String?, susshiDescription: String?, susshiStoreId: String?, susshiPrice: Int?) {
        self.susshiName = susshiName
        self.susshiImage = susshiImage
        self.susshiDescription = susshiDescription
        self.susshiStoreId = susshiStoreId
        self.susshiPrice = susshiPrice
    }

}
