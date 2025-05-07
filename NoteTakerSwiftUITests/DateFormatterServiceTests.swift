//
//  DateFormatterServiceTests.swift
//  NoteTakerSwiftUITests
//
//  Created by Abigail Mariano on 5/7/25.
//

import XCTest
@testable import NoteTakerSwiftUI

final class DateFormatterServiceTests: XCTestCase {
    var sut: DateFormatterService!
    
    override func setUp() {
        super.setUp()
        sut = DateFormatterService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFormatDate() {
        // Given
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2025
        dateComponents.month = 5
        dateComponents.day = 10
        dateComponents.hour = 14
        dateComponents.minute = 30
        
        let testDate = calendar.date(from: dateComponents)!
        
        // When
        let formattedDate = sut.formatDate(testDate)
        
        // Then
        XCTAssertTrue(formattedDate.contains("2025"))
        XCTAssertTrue(formattedDate.contains("May") || formattedDate.contains("5"))
        XCTAssertTrue(formattedDate.contains("10"))
    }
}
