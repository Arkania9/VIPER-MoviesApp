//
//  Constants.swift
//  ViperMoviesApp
//
//  Created by Kamil Zajac on 05.05.2017.
//  Copyright © 2017 Kamil Zajac. All rights reserved.
//

import UIKit

struct APIKey {
    static let APIKey = "?api_key=6fc7bdce0b611a967ff8b6a61f9fc6e8&language=en-US"
}

struct MovieURL {
    static let MovieURL = "https://api.themoviedb.org/3/"
}

struct Number {
    static let formatterWithSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var stringFormattedWithSeparator: String {
        return Number.formatterWithSeparator.string(from: self as! NSNumber) ?? ""
    }
}
