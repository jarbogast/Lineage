//
//  Family.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/19/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import Foundation

class Family: Record {
    var husbandId: String?

    override init(withId id: String, childRecords: [String]) {
        super.init(withId: id, childRecords: childRecords)
        husbandId = parseChildren(childRecords)
    }
    
    func parseChildren(children: [String]) -> String? {
        let fieldSeparators = NSCharacterSet.whitespaceCharacterSet()
        
        for line in children {
            let lineComponents = line.componentsSeparatedByCharactersInSet(fieldSeparators)
            
            let fieldName = lineComponents[1]
            switch fieldName {
            case "HUSB":
                return lineComponents[2].stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "@"))
            default:
                return nil
            }
        }
        
        return nil
    }
}
