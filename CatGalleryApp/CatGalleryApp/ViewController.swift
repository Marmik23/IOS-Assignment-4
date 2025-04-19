//
//  ViewController.swift
//  CatGalleryApp
//
//  Created by Marmik Nalinkumar Patel on 2025-04-19.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var catFactLabel: UILabel!
    @IBOutlet weak var showGalleryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRandomCat()
    }
    
    func loadRandomCat() {
        CatAPIManager.shared.fetchRandomCatImage { [weak self] url in
            guard let self = self, let url = url, let imageURL = URL(string: url) else { return }
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.catImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        CatAPIManager.shared.fetchCatFact { [weak self] fact in
            DispatchQueue.main.async {
                self?.catFactLabel.text = fact ?? "No fact found."
            }
        }
    }
    
}

