//
//  ProductsViewController.swift
//  products mvvm
//
//  Created by SUMSKAR PC on 11/05/24.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var tbleView: UITableView!
    
    let activityIndicator=UIActivityIndicatorView(style: .large)
let viewModel=ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tbleView.delegate=self
        tbleView.dataSource=self
        tbleView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
     
configure()
       setupActivityIndicator()
    }
    

}

extension ProductsViewController{
    func configure(){
        initViewModel()
        observeEvent()
        print("<<<<<count \(viewModel.arr_products.count)")
    }
    func initViewModel(){
        viewModel.getProducts()
    }
    func setupActivityIndicator(){
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(activityIndicator)
            
            // Center the activity indicator horizontally
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            
    }
    func observeEvent(){
        viewModel.eventHandler={[weak self] event in
            guard let self else{return}
            
            switch event{
                
            case .loading:
                DispatchQueue.main.async{
                    self.activityIndicator.startAnimating()
                }
                
                
            case .stopLoading:
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                }
                
            case .loaded:
                print(viewModel.arr_products)
                DispatchQueue.main.async{
                    self.tbleView.reloadData()
                }
                
            case .error(_):
                break
            }
        }
    }
}

extension ProductsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.arr_products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
            let product = viewModel.arr_products[indexPath.row]
            cell.product = product // Set the product property of the cell
            cell.configureProduct() // Configure the cell with the product data
            return cell
    }
    
    
}
