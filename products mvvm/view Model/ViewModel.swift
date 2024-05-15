//
//  ViewModel.swift
//  products mvvm
//
//  Created by SUMSKAR PC on 11/05/24.
//

import Foundation


final class ViewModel {
    var eventHandler:((_ event:Event)->Void)?
    var arr_products:[Product]=[]
    
    func getProducts() {
        self.eventHandler?(.loading)
        ApiManager.shared.get { [weak self] result in
            guard let self = self else { return }
            self.eventHandler?(.stopLoading)
            switch result {
            case .success(let products):
                self.arr_products = products
                self.eventHandler?(.loaded)
                print(products) // Print products here
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }


}

extension ViewModel{
    
    enum Event{
        case loading
        case stopLoading
        case loaded
        case error(Error?)
    }
}
