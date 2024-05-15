//
//  ProductTableViewCell.swift
//  products mvvm
//
//  Created by SUMSKAR PC on 13/05/24.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    var product:Product?
    @IBOutlet weak var imageProduct: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
 
    @IBOutlet weak var details: UILabel!
    
    @IBOutlet weak var descritnLbl: UILabel!
    @IBOutlet weak var btnRating: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
            }
    func configureProduct(){
        guard let product else{return}
        imageProduct.image = UIImage()
        title.text=String(product.price)
        details.text=product.description
        btnRating.setTitle(String(product.rating.rate)
            , for: .normal)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
