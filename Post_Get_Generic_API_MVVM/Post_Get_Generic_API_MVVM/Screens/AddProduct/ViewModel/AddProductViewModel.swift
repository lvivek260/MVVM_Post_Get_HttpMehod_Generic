//
//  GetProductViewModel.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import Foundation

final class AddProductViewModel{
    var eventHandler: ((_ event: Event)->Void)?
    var product: AddProductModel?
    
    func addProduct(product: AddProductModel){
        DispatchQueue.main.async {
            self.eventHandler?(.startLoading)
        }
        
        APIManager.shared.fetchData(
            model: AddProductModel.self,
            type: .addProduct(product: product)
        ){ result in
            self.eventHandler?(.stopLoading)
            
            switch result{
            case .failure(let error):
                self.eventHandler?(.error(error))
                break
                
            case .success(let product):
                self.product = product
                self.eventHandler?(.reloadData)
                break
            }
        }
    }
}
