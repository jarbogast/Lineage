//
//  GedcomParser.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/17/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import Foundation

class GedcomParser {
    
    func parseRecords(fileContents: String) -> (header: Header?, submissionRecord: SubmissionRecord?, records: [IndividualRecord], trailer: Trailer?) {
        let lineTerminators = NSCharacterSet.newlineCharacterSet()
        let lines = fileContents.componentsSeparatedByCharactersInSet(lineTerminators)
        let fieldSeparators = NSCharacterSet.whitespaceCharacterSet()
        
        var headerRecord: Header?
        var submissionRecord: SubmissionRecord?
        var individuals = [IndividualRecord]()
        var trailerRecord: Trailer?
        
        for line in lines {
            let lineComponents = line.componentsSeparatedByCharactersInSet(fieldSeparators)
            let fieldName = lineComponents[1]
            
            if fieldName == "HEAD" {
                headerRecord = Header()
            } else if fieldName == "SUBN" {
                submissionRecord = SubmissionRecord()
            } else if fieldName == "INDI" {
                individuals.append(IndividualRecord())
            } else if fieldName == "TRLR" {
                trailerRecord = Trailer()
            }
        }
        
        return (headerRecord, submissionRecord, individuals, trailerRecord)
    }
    
}