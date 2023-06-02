//
//  ViewController.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import UIKit

class AddProductViewController: UIViewController {

    let viewModel = AddProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiConfiguration()
    }
}

extension AddProductViewController{
    func apiConfiguration(){
        addProduct()
        eventObserver()
    }
    func addProduct(){
        let product = AddProductModel(title: "vivek Lokhande")
        viewModel.addProduct(product: product)
    }
    func eventObserver(){
        self.viewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            
            switch event{
            case .startLoading:
                print(event)
                break
                
            case .stopLoading:
                print(event)
                break
                
            case .reloadData:
                print(event)
                print(self.viewModel.product as Any)
                break
                
            case .error(let err):
                print(err)
            }
        }
    }
}
