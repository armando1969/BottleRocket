//
//  RestaurantCell.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/7/22.
//

import UIKit
import WebKit

protocol RestaurantCellDelegate: AnyObject {
    func setImageData(_ data: Data, key: String?)
}

class RestaurantCell: UICollectionViewCell {
    
    weak var delegate: RestaurantCellDelegate?
    
    static let reuseIdentifier = "RestaurantCell"
    
    @IBOutlet private weak var restaurantImage: UIImageView!
    @IBOutlet private weak var restaurantTitle: UILabel!
    @IBOutlet private weak var restaurantCategory: UILabel!
    
    func configureCell(title: String?, category: String, imageURL: String, imageData: Data?) {
        
        restaurantTitle.text = title
        restaurantTitle.textColor = .white
        restaurantCategory.text = category
        restaurantCategory.textColor = .white
        
        // clean image
        restaurantImage.image = nil
        
        if let imageData = imageData {
            let image = UIImage(data: imageData)
            restaurantImage.image = image
        } else {
            NetworkManager.getImageData(imageURL) { data in
                DispatchQueue.global().async {
                    if let data = data {
                        self.delegate?.setImageData(data, key: title)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.restaurantImage.image = image
                        }
                    }
                }
            }
        }
        
    }
    
}
