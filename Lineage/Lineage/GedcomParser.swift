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
        
        var header: Header?
        var submissionRecord: Submission?
        var records = [Record]()
        var trailer: Trailer?
        
        for line in lines {
            let lineComponents = line.componentsSeparatedByCharactersInSet(fieldSeparators)
            let fieldName = lineComponents[1]
            let fieldTag = RecordTag(rawValue: fieldName)!
            
            switch fieldTag {
            case .Header:
                header = Header()
            case .Submission:
                submissionRecord = Submission()
            case .Family:
                records.append(Family())
            case .Individual:
                records.append(Individual())
            case .Multimedia:
                records.append(Multimedia())
            case .Note:
                records.append(Note())
            case .Repository:
                records.append(Repository())
            case .Source:
                records.append(Source())
            case .Submitter:
                records.append(Submitter())
            case .Trailer:
                trailer = Trailer()
            }
        }
        
        return (header, submissionRecord, records, trailer)
    }
    
}