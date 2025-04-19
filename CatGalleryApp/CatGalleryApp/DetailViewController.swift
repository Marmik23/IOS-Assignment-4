//
//  DetailViewController.swift
//  CatGalleryApp
//
//  Created by Marmik Nalinkumar Patel on 2025-04-19.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var factLabel: UILabel!
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlString = imageUrl, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.catImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        CatAPIManager.shared.fetchCatFact { [weak self] fact in
            DispatchQueue.main.async {
                self?.factLabel.text = fact ?? "No fact found."
            }
        }
    }
}
