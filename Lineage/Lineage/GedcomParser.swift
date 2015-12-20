//
//  GedcomParser.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/17/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import Foundation

class GedcomParser {
    
    static func parseRecords(fileContents: String) -> (header: Header?, submissionRecord: Submission?, records: [Record], trailer: Trailer?) {
        let lineTerminators = NSCharacterSet.newlineCharacterSet()
        let lines = fileContents.componentsSeparatedByCharactersInSet(lineTerminators)
        
        var header: Header?
        var submissionRecord: Submission?
        var records = [Record]()
        var trailer: Trailer?
        
        var recordLine: String? = nil
        var childLines = [String]()
        
        for line in lines {
            let lineComponents = parseLine(line)
            if lineComponents.level == "0" {
                if let recordLine = recordLine {
                    let record = parseRecordLine(recordLine, childLines: childLines)
                    if let parsedHeader = record.header {
                        header = parsedHeader
                    } else if let parsedSubmissionRecord = record.submissionRecord {
                        submissionRecord = parsedSubmissionRecord
                    } else if let parsedRecord = record.record {
                        records.append(parsedRecord)
                    } else if let parsedTrailer = record.trailer {
                        trailer = parsedTrailer
                    }
                }
                recordLine = line
            } else {
                childLines.append(line)
            }
        }

        if let recordLine = recordLine {
            let record = parseRecordLine(recordLine, childLines: childLines)
            if let parsedHeader = record.header {
                header = parsedHeader
            } else if let parsedSubmissionRecord = record.submissionRecord {
                submissionRecord = parsedSubmissionRecord
            } else if let parsedRecord = record.record {
                records.append(parsedRecord)
            } else if let parsedTrailer = record.trailer {
                trailer = parsedTrailer
            }
        }
        
        return (header, submissionRecord, records, trailer)
    }
    
    static func parseRecordLine(recordLine: String, childLines: [String]) -> (header: Header?, submissionRecord: Submission?, record: Record?, trailer: Trailer?) {
        let lineComponents = parseLine(recordLine)
        let recordTag = RecordTag(rawValue: lineComponents.recordName)!
        
        var header: Header?
        var submissionRecord: Submission?
        var record: Record?
        var trailer: Trailer?
        
        switch recordTag {
        case .Header:
            header = Header()
        case .Submission:
            submissionRecord = Submission()
        case .Family:
            record = Family(withId: lineComponents.referenceId, childRecords: childLines)
        case .Individual:
            record = Individual()
        case .Multimedia:
            record = Multimedia()
        case .Note:
            record = Note()
        case .Repository:
            record = Repository()
        case .Source:
            record = Source()
        case .Submitter:
            record = Submitter()
        case .Trailer:
            trailer = Trailer()
        }
        
        return (header, submissionRecord, record, trailer)
    }
    
    static func parseLine(line: String) -> (level: String, referenceId: String, recordName: String) {
        let fieldSeparators = NSCharacterSet.whitespaceCharacterSet()
        let lineComponents = line.componentsSeparatedByCharactersInSet(fieldSeparators)
        
        if lineComponents.count == 2 {
            return(lineComponents[0], "", lineComponents[1])
        } else {
            return(lineComponents[0], lineComponents[1], lineComponents[2])
        }
    }
}