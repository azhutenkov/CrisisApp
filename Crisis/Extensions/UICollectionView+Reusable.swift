//
//  UICollectionView+Reusable.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 02/02/2020.
//

import UIKit

extension UICollectionViewCell: Reusable {}

extension UICollectionView {

	// MARK: RegisterReusable

	func registerReusable<T: Reusable>(cellClass: T.Type) {
		register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
	}

	func registerReusable<T: Reusable>(cellNibClass: T.Type, nib: UINib? = nil, bundle: Bundle = Bundle.main) {
		register(nib ?? UINib(nibName: T.reuseIdentifier, bundle: bundle), forCellWithReuseIdentifier: T.reuseIdentifier)
	}

	// MARK: DequeueReusableCell

	func dequeueReusableCell<T: UICollectionViewCell>(withClass reusableClass: T.Type, for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: reusableClass.reuseIdentifier, for: indexPath) as? T
			else {
				fatalError("dequeueReusableCell(withReuseIdentifier:for:)")
		}
		return cell
	}
}
