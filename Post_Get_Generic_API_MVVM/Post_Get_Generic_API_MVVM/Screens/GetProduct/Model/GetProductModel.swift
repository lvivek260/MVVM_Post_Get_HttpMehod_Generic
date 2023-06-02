//
//  GetProductModel.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import Foundation

struct GetProductModel: Codable{
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
struct Product: Codable{
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
}

