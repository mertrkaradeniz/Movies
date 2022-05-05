//
//  Extensions.swift
//  Movies
//
//  Created by Mert Karadeniz on 25.04.2022.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else { fatalError() }
        return cell
    }
}

public extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }

    func registerView(cellType: UICollectionReusableView.Type, kind: String = UICollectionView.elementKindSectionHeader) {
        register(cellType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.identifier)
    }

    func dequeView<T: UICollectionReusableView>(cellType: T.Type,
                                                kind: String = UICollectionView.elementKindSectionHeader,
                                                indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return reusableView
    }
}

extension UISearchBar {
    func setupSearchBar(background: UIColor = .white, inputText: UIColor = .black, placeholderText: UIColor = .gray, image: UIColor = .black) {
        self.searchBarStyle = .minimal
        self.barStyle = .default
        // IOS 12 and lower:
        for view in self.subviews {
            for subview in view.subviews where subview is UITextField {
                if let textField: UITextField = subview as? UITextField {
                    // Background Color
                    textField.backgroundColor = background
                    //   Text Color
                    textField.textColor = inputText
                    //  Placeholder Color
                    textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                                         attributes: [NSAttributedString.Key.foregroundColor: placeholderText])
                    //  Default Image Color
                    if let leftView = textField.leftView as? UIImageView {
                        leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                        leftView.tintColor = image
                    }
                    let backgroundView = textField.subviews.first
                    backgroundView?.backgroundColor = background
                    backgroundView?.layer.cornerRadius = 10.5
                    backgroundView?.layer.masksToBounds = true
                }
            }
        }
        // IOS 13 only:
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = background
            textField.textColor = inputText
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: placeholderText])
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = image
            }
        }
    }
}
