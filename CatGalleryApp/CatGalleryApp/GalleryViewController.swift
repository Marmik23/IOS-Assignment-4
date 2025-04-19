//
//  GalleryViewController.swift
//  CatGalleryApp
//
//  Created by Marmik Nalinkumar Patel on 2025-04-19.
//

import UIKit

class GalleryViewController: UITableViewController {
    var catImageUrls: [String] = []
    var selectedImageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cat Gallery"
        CatAPIManager.shared.fetchCatImages(count: 20) { [weak self] urls in
            DispatchQueue.main.async {
                self?.catImageUrls = urls
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catImageUrls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GalleryCell", for: indexPath)
        let urlString = catImageUrls[indexPath.row]
        cell.textLabel?.text = "Cat #\(indexPath.row + 1)"
        cell.imageView?.image = UIImage(systemName: "photo")
        if let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail",
               let detailVC = segue.destination as? DetailViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                detailVC.imageUrl = catImageUrls[indexPath.row]
            }
    }
}
