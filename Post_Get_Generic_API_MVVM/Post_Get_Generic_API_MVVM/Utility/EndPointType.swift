//
//  EndPointType.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import Foundation

enum HttpMethod: String{
    case get = "GET"
    case post = "POST"
}

protocol EndPointType{
    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var httpMethod: HttpMethod { get }
    var body: Encodable? { get }
    var headers: [String : String]? { get }
}

enum EndPointItems{
    case getProduct
    case addProduct(product: AddProductModel)
}

extension EndPointItems: EndPointType{
    var baseURL: String {
        return "https://dummyjson.com/"
    }
    
    var path: String {
        switch self{
        case .addProduct:
            return "products/add"
        case .getProduct:
            return "products"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var httpMethod: HttpMethod {
        switch self{
        case .addProduct:
            return .post
        case .getProduct:
            return .get
        }
    }
    
    var body: Encodable? {
        switch self {
        case .getProduct:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManager.shared.commonAPIHeader
    }
}
