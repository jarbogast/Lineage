//
//  Record.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/17/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import Foundation

class Record {
    let id: String?
    let childRecords: [Record]
    
    init() {
        id = ""
        childRecords = []
    }
    
    init(withId id: String, childRecords: [String]) {
        self.id = id
        self.childRecords = []
    }
}
