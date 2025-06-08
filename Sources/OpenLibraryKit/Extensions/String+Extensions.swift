//
//  String+Extensions.swift
//  OpenLibraryKit
//
//  Created by Todd Martin on 6/8/25.
//

import Foundation

extension String {
    var urlSafeString: String {
        self.replacingOccurrences(of: " ", with: "+")
    }
    
    var isbnQueryable: String {
        self + ".json"
    }
}
