//
//  GedcomParserTestCase.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/17/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Lineage

class GedcomParserTestCase: XCTestCase {
    
    func testParseHeader() {
        let documentLayout = GedcomParser.parseRecords("0 HEAD")
        
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 0)
        XCTAssertNil(documentLayout.trailer)
    }

    func testParseNoHeaderOneIndividual() {
        let documentLayout = GedcomParser.parseRecords("0 INDI")
        
        XCTAssertNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailer)
    }
    
    func testParseHeaderAndOneIndividual() {
        let documentLayout = GedcomParser.parseRecords(   "0 HEAD\n" +
                                                    "0 INDI")
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailer)
    }
    
    func testParseAllRecordTypes() {
        let documentLayout = GedcomParser.parseRecords(   "0 HEAD\n" +
                                                    "0 SUBN\n" +
                                                    "0 FAM\n" +
                                                    "0 INDI\n" +
                                                    "0 OBJE\n" +
                                                    "0 NOTE\n" +
                                                    "0 REPO\n" +
                                                    "0 SOUR\n" +
                                                    "0 SUBM\n" +
                                                    "0 TRLR")
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNotNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 7)
        XCTAssertNotNil(documentLayout.trailer)
    }
    
}
