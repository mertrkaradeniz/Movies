//
//  SliderTableViewCell.swift
//  Movies
//
//  Created by Mert Karadeniz on 28.04.2022.
//

import UIKit

final class SliderTableViewCell: UITableViewCell {

    @IBOutlet private weak var sliderCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var pageControlBackground: UIView!
    
    private var movies = [Movie]()
    private var timer = Timer()
    private var currentCellIndex = 0
    var didSelectItemAt: ((Int) -> ())?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        sliderCollectionView.register(cellType: SliderCollectionViewCell.self)
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        setupTimer()
    }
    
    private func setupTimer() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.moveToNextCell), userInfo: nil, repeats: true)
        }
    }
    
    @objc func moveToNextCell() {
        if currentCellIndex < movies.count - 1 {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
    }
    
    func configure(with movies: [Movie]) {
        self.movies = movies
        pageControl.numberOfPages = movies.count
        sliderCollectionView.reloadData()
    }
}

extension SliderTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

extension SliderTableViewCell: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentCellIndex = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        pageControl.currentPage = currentCellIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt?(indexPath.row)
    }
}

extension SliderTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = sliderCollectionView.dequeCell(cellType: SliderCollectionViewCell.self, indexPath: indexPath)
        cell.configure(with: movies[indexPath.row])
        return cell
    }
}
