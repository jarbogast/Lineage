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
    let parser = GedcomParser()
    
    func testParseHeader() {
        let documentLayout = parser.parseRecords("0 HEAD")
        
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 0)
        XCTAssertNil(documentLayout.trailer)
    }

    func testParseNoHeaderOneIndividual() {
        let documentLayout = parser.parseRecords("0 INDI")
        
        XCTAssertNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailer)
    }
    
    func testParseHeaderAndOneIndividual() {
        let documentLayout = parser.parseRecords(   "0 HEAD\n" +
                                                    "0 INDI")
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailer)
    }
    
    func testParseHeaderSubmissionIndividualAndTrailer() {
        let documentLayout = parser.parseRecords(   "0 HEAD\n" +
                                                    "0 SUBN\n" +
                                                    "0 INDI\n" +
                                                    "0 TRLR")
        XCTAssertNotNil(documentLayout.header)
        XCTAssertNotNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNotNil(documentLayout.trailer)
    }
    
}
