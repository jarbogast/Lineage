//
//  GedcomParser.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/17/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import Foundation

class GedcomParser {
    
    func parseRecords(fileContents: String) -> (header: Header?, submissionRecord: Submission?, records: [Record], trailer: Trailer?) {
        let lineTerminators = NSCharacterSet.newlineCharacterSet()
        let lines = fileContents.componentsSeparatedByCharactersInSet(lineTerminators)
        let fieldSeparators = NSCharacterSet.whitespaceCharacterSet()
        
        var headerRecord: Header?
        var submissionRecord: Submission?
        var individuals = [Record]()
        var trailerRecord: Trailer?
        
        for line in lines {
            let lineComponents = line.componentsSeparatedByCharactersInSet(fieldSeparators)
            let fieldName = lineComponents[1]
            let fieldTag = RecordTag(rawValue: fieldName)!
            
            switch fieldTag {
            case .Header:
                headerRecord = Header()
            case .Submission:
                submissionRecord = Submission()
            case .Individual:
                individuals.append(Individual())
            case .Trailer:
                trailerRecord = Trailer()
            }
        }
        
        return (headerRecord, submissionRecord, individuals, trailerRecord)
    }
    
}