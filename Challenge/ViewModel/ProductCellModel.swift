//
//  ProductCellModel.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-28.
//

import Foundation

class ProductCellModel {
    let title: String?
    let productImage: String?
    let listPrice: Double?
    let yourPrice: Double?
    let hasBadge: Bool?
    let badgeImageURL: String?
    var isFavourite: Bool?
    
    init(with product: Products) {
        title = product.name
        productImage = product.mainImage
        listPrice = product.vendorInventory.first?.listPrice ?? 0.0
        yourPrice = product.vendorInventory.first?.price ?? 0.0
        hasBadge = product.advertisingBadges.hasBadge
        badgeImageURL = product.advertisingBadges.badges?.first?.badgeImageURL
        isFavourite = product.isFavourite
    }
}
