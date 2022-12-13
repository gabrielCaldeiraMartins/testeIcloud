//
//  MathTests.swift
//  testCameraTests
//
//  Created by Gabriel Caldeira on 13/12/22.
//

import XCTest
@testable import testCamera

final class MathTests: XCTestCase {
    
    var sut: Math!
    
    override func setUpWithError() throws {
        sut = Math()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    
    func testAdditionOfPositiveNumbers() {
        // Given
        let num1 = 2
        let num2 = 5
        //When
        let result = sut.add(numb1: num1, numb2: num2)
        //Then
        XCTAssertEqual(result, 7)
        
    }
    
    func testAdditionOfNegativeNumbers() {
        // Given
        let num1 = 2
        let num2 = -5
        //When
        let result = sut.add(numb1: num1, numb2: num2)
        //Then
        XCTAssertEqual(result, -3)
        
    }

}
