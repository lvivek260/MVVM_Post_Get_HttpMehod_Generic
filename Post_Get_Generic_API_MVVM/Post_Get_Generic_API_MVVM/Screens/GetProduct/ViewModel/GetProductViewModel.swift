//
//  GetProductViewModel.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import Foundation
final class GetProductViewModel{
    var products: [Product] = []
    var eventHandler: ((_ event: Event)->Void)?
    
    func fetchProducts(){
        DispatchQueue.main.async {
            self.eventHandler?(.startLoading)
        }
        APIManager.shared.fetchData(
            model: GetProductModel.self,
            type: .getProduct
        ){ result in
            self.eventHandler?(.stopLoading)
            switch result{
            case .success(let products):
                self.products = products.products
                self.eventHandler?(.reloadData)
                break
                
            case .failure(let error):
                self.eventHandler?(.error(error))
                break
            }
        }
    }
}
