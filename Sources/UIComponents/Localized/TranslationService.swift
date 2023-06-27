//
//  TranslationService.swift
//  UIComponents
//
//  Created by Daniel Mandea on 02.01.2023.
//  Copyright © 2022 MTD Technology (publ). All rights reserved.
//

import Foundation

final class TranslationService {
    static let bundle: Bundle = {  Bundle.module }()
    
    static func lookupTranslation(forKey key: String, inTable table: String, value: String) -> String {
        bundle.localizedString(forKey: key, value: value, table: "Localizable")
    }
}
