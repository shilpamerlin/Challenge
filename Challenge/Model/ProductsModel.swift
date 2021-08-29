//
//  ProductsModel.swift
//  Challenge
//
//  Created by Shilpa Joy on 2021-08-26.
//

import Foundation

struct Results: Codable {
    let hits: [Products]
}

struct Products: Codable {
    let name: String?
    let mainImage: String?
    let isFavourite: Bool?
    let vendorInventory: [VendorInventory]
    let advertisingBadges: AdvertisingBadges
    enum CodingKeys: String, CodingKey {
        case name
        case mainImage = "main_image"
        case isFavourite = "is_favourite_product"
        case vendorInventory = "vendor_inventory"
        case advertisingBadges = "advertising_badges"
    }
}

struct VendorInventory: Codable {
    let listPrice: Double?
    let price: Double?
    enum CodingKeys: String, CodingKey {
        case listPrice = "list_price"
        case price
    }
}

struct AdvertisingBadges: Codable {
    let hasBadge: Bool?
    let badges: [Badge]?
    enum CodingKeys: String, CodingKey {
            case hasBadge = "has_badge"
            case badges
    }
}
struct Badge: Codable {
    let badgeImageURL: String

    enum CodingKeys: String, CodingKey {
        case badgeImageURL = "badge_image_url"
    }
}
