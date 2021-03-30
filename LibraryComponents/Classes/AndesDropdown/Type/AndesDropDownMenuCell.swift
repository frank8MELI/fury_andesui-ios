//
//  File.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 20/11/20.
//

import Foundation

@objc public class AndesDropDownMenuCell: NSObject {
    public private(set) var title: String
    public private(set) var thumbnail: AndesThumbnail?
    /**
     This class define the AndesList cell inside AndesDropdown
     - Parameters:
        - title: Define the cell title
        - thumbnail: Define the image cell
    */
    @objc public init(title: String, thumbnail: AndesThumbnail? = nil) {
        self.title = title
        self.thumbnail = thumbnail
    }
}
