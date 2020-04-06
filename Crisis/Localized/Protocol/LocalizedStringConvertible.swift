//
//  LocalizedStringConvertible.swift
//  Crisis
//
//  Created by Alexey Zhutenkov on 06/10/2019.
//

import Foundation

///General protocol for localization strings
protocol LocalizedStringConvertible {

	///Key for string line in localizable file
	///Rule for key it's a name, it's must be a enum inherited from the LocalizedStringConvertible
	///Key format is "YourEnum_enumValueLikeAKey"
	var key: String { get }

	///Localized line for your key in Localizable.strings
	var localized: String { get }

	///Can be used for easy formating lines.
	///Works correctly only on a real device.
	///1 - it's formatable line in Localizable.strings
	///Example: "Yuriy has %@ tickets to a concert and %@ to the cinema."
	///2 - Declension of words by the rules of the language, key must be in Localizable.stringsdict
	func localized(withArgs args: CVarArg...) -> String
}

extension LocalizedStringConvertible {

	var key: String {
		return String(describing: type(of: self)) + "_" + String(describing: self)
	}

	var localized: String {
		return NSLocalizedString(key, comment: "")
	}

	func localized(withArgs args: CVarArg...) -> String {
		return String(format: localized, locale: Locale.current, arguments: args)
	}
}
