//
//  SushiViewModel.swift
//  DinDin Food App
//
//  Created by Babatunde Adewole on 11/19/20.
//

import Foundation
struct SushiViewModel {
    let susshiName: String?
    let susshiImage: String?
    let susshiDescription: String?
    let susshiStoreId: String?
    let susshiPrice: Int?

    init(sushiModel: SushiModel) {
        self.susshiName = sushiModel.susshiName
        self.susshiImage = sushiModel.susshiImage
        self.susshiDescription = sushiModel.susshiDescription
        self.susshiStoreId = sushiModel.susshiStoreId
        self.susshiPrice = sushiModel.susshiPrice
    }

}
