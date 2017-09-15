//
//  CollectionRowSections.swift
//  BloodDonationIOS
//
//  Created by Richard Moult on 1/9/17.
//  Copyright © 2017 Richard Moult. All rights reserved.
//

import Foundation


struct CollectionRow<T> {
    let data:T
    let cellIdentifier: String
}


struct CollectionSection<T> {
    let title: String?
    let rows:[CollectionRow<T>]
    
//    static func combine(rows:[CollectionRow<T>]...) -> [CollectionSection<T>] {
//        var sections: [CollectionSection<T>] = []
//        for row: [CollectionRow<T>] in rows {
//            sections.append( CollectionSection<T>(rows:row) )
//        }
//        return sections
//    }
}
