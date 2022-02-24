//
//  UIImageView+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImageWithLink(_ imgLink: String, imageHolder: UIImage?) {
        if let url = URL(string: imgLink) {
            loadImageWithUrl(url, imageHolder: imageHolder)
        } else if let imgEnd = imgLink.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: imgEnd) {
                loadImageWithUrl(url, imageHolder: imageHolder)
            }
        }
    }
    func loadImageWithUrl(_ url: URL?, imageHolder: UIImage?) {
        self.sd_setImage(with: url, placeholderImage: imageHolder, options: [.refreshCached, .retryFailed], completed: nil)
    }
    
    func cancelLoadingImage() {
        self.sd_cancelCurrentImageLoad()
    }
}
