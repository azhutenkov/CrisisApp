//
//  UITableView+Reusable.swift
//  carsharing
//
//  Created by Alexey Zhutenkov on 06/10/2019.
//

import UIKit

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

extension UITableView {

	// MARK: RegisterReusable

	func registerReusable<T: Reusable>(cellClass: T.Type) {
		register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
	}

	func registerReusable<T: Reusable>(cellNibClass: T.Type, nib: UINib? = nil, bundle: Bundle = Bundle.main) {
		register(nib ?? UINib(nibName: T.reuseIdentifier, bundle: bundle) , forCellReuseIdentifier: T.reuseIdentifier)
	}

	// MARK: DequeueReusableCell

	func dequeueReusableCell<T: UITableViewCell>(withClass reusableClass: T.Type, for indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withIdentifier: reusableClass.reuseIdentifier, for: indexPath) as? T
			else {
				fatalError("dequeueReusableCell(withClass:for:)")
		}
		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(withClass reusableClass: T.Type) -> T? {
		return dequeueReusableCell(withIdentifier: reusableClass.reuseIdentifier) as? T
	}

	func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass reusableClass: T.Type) -> T? {
		return dequeueReusableHeaderFooterView(withIdentifier: reusableClass.reuseIdentifier ) as? T
	}

	// MARK: RegisterReusableForHeaderFooter

	func registerReusableForHeaderFooterView<T: UITableViewHeaderFooterView>(reusableClass: T.Type, nib: UINib? = nil) {
		register(
			nib ?? UINib(nibName: T.reuseIdentifier, bundle: Bundle.main),
			forHeaderFooterViewReuseIdentifier: reusableClass.reuseIdentifier
		)
	}

	func registerReusableForHeaderFooterView<T: UITableViewHeaderFooterView>(viewClass: T.Type) {
		register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
	}
}
