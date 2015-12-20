//
//  FamilyTestCase.swift
//  Lineage
//
//  Created by Jonathan Arbogast on 12/20/15.
//  Copyright © 2015 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Lineage

class FamilyTestCase: XCTestCase {

    let family = Family(withId: "4", childRecords: "")

    func testInitializer() {
        XCTAssertEqual(family.id, "4")
    }

}
