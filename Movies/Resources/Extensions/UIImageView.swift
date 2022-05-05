//
//  ImageView.swift
//  Movies
//
//  Created by Mert Karadeniz on 28.04.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URL?) {
        guard let url = url else { return }
        let placeholder = UIImage(named: "no-image-available")
        self.kf.indicatorType = .activity
        
        self.kf.setImage(with: url, options: [
            .loadDiskFileSynchronously,
            .cacheOriginalImage
        ]) { result in
            switch result {
            case .failure(_):
                self.image = placeholder
            case .success(_):
                break
            }
        }
    }
    
    func setImageRounded(url: URL?, round: CGFloat) {
        guard let url = url else { return }
        let placeholder = UIImage(named: "no-image-available")
        let roundCorner = RoundCornerImageProcessor(cornerRadius: round)
        self.kf.indicatorType = .activity
        
        self.kf.setImage(with: url, options:[
            .processor(roundCorner), .loadDiskFileSynchronously,
            .cacheOriginalImage]) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(_):
                    self.image = placeholder
                case .success(_):
                    break
                }
            }
    }
}
