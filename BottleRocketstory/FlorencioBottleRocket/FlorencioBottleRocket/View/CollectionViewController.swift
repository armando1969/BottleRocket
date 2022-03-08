//
//  CollectionViewController.swift
//  FlorencioBottleRocket
//
//  Created by Florencio Gallegos on 3/6/22.
//


import UIKit

class CollectionViewController: UIViewController {

    private var restaurants = [Restaurant]()
    private var cache = [String: Data]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lunch Tyme"
        setUpCollectionView()
        getBuild()

    }

    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        let size = CGSize(width: width, height: 180)
        layout.itemSize = size
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    private func getImageData(for key: String) -> Data? {
        return cache[key]
    }
    
    private func getBuild() {
        NetworkManager
            .getRestaurant(from: "https://s3.amazonaws.com/br-codingexams/restaurants.json") { [weak self] result in
                switch result {
                case .success(let response):
                    self?.restaurants = response.restaurants
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

}

extension CollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantCell.reuseIdentifier, for: indexPath) as! RestaurantCell
        let restaurant = restaurants[indexPath.row]
        let name = restaurant.name
        let imageData = getImageData(for: name ?? "")
        cell.delegate = self
        cell.configureCell(title: name, category: restaurant.category ?? "", imageURL: restaurant.backgroundImageURL ?? "", imageData: imageData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let restaurant = restaurants[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.restaurantName = restaurant.name ?? ""
        vc?.restaurantCategory = restaurant.category ?? ""
        vc?.formatedAddress = restaurant.location?.formattedAddress ?? ["", ""]
        vc?.formatedPhone = restaurant.contact?.formattedPhone ?? ""
        vc?.twitterHandle = restaurant.contact?.twitter ?? ""
        vc?.long = restaurant.location?.lng ?? 0.0
        vc?.lat = restaurant.location?.lat ?? 0.0
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension CollectionViewController: RestaurantCellDelegate {
    func setImageData(_ data: Data, key: String?) {
        guard let key = key
        else { return }
        DispatchQueue.main.async {
            self.cache[key] = data
        }
    }
}
