//
//  GetProductViewController.swift
//  Post_Get_Generic_API_MVVM
//
//  Created by Mac on 17/05/23.
//

import UIKit

class GetProductViewController: UIViewController {
    let viewModel = GetProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiConfiguration()
    }
}

extension GetProductViewController{
    func apiConfiguration(){
        fetchAPI()
        observeEvent()
    }
    func fetchAPI(){
        viewModel.fetchProducts()
    }
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
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
                print(self.viewModel.products.count)
                break
                
            case .error(let err):
                print(err)
                break
            }
        }
    }
}
