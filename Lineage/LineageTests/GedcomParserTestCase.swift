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
        
        XCTAssertNotNil(documentLayout.headerRecord)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 0)
        XCTAssertNil(documentLayout.trailerRecord)
    }

    func testParseNoHeaderOneIndividual() {
        let documentLayout = parser.parseRecords("0 INDI")
        
        XCTAssertNil(documentLayout.headerRecord)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailerRecord)
    }
    
    func testParseHeaderAndOneIndividual() {
        let documentLayout = parser.parseRecords(   "0 HEAD\n" +
                                                    "0 INDI")
        XCTAssertNotNil(documentLayout.headerRecord)
        XCTAssertNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNil(documentLayout.trailerRecord)
    }
    
    func testParseHeaderSubmissionIndividualAndTrailer() {
        let documentLayout = parser.parseRecords(   "0 HEAD\n" +
                                                    "0 SUBN\n" +
                                                    "0 INDI\n" +
                                                    "0 TRLR")
        XCTAssertNotNil(documentLayout.headerRecord)
        XCTAssertNotNil(documentLayout.submissionRecord)
        XCTAssertEqual(documentLayout.records.count, 1)
        XCTAssertNotNil(documentLayout.trailerRecord)
    }
    
}
