//
//  SGDSTestBinarySearchTree.swift
//  SGDSTests
//
//  Created by Stanley Rosenbaum on 2/7/21.
//

import XCTest
@testable import SGDS

class SGDSTestBinarySearchTree: XCTestCase {

	func testExample() {
		// This is an example of a functional test case.
		// Use XCTAssert and related functions to verify your tests produce the correct
		// results.
		XCTAssertEqual(SGDS().text, "Hello, World!")
	}

	func testBinarySearchNode() {
		let test = BinarySearchTreeNode(data: 5)
		XCTAssertEqual(test.data, 5, "Not Equal to 5")
	}

	func testBinarySearchTreeLeftRotateTest() {
		let tree = BinarySearchTree<Int>()
		tree.insertData(1)
		tree.insertData(3)
		tree.insertData(2)
		tree.insertData(4)

		print("\(tree)")
		tree.testRotateLeftFromRoot()
		print("\(tree)")


	}


	func testBinarySearchTreeRightRotateTest() {
		let tree = BinarySearchTree<Int>()
		tree.insertData(4)
		tree.insertData(2)
		tree.insertData(1)
		tree.insertData(3)

		print("\(tree)")

		tree.testRotateRightFromRoot()

		print("\(tree)")

	}


	func testBinarySearchTreeInsertAndBalanceCheck1() {
		let tree = BinarySearchTree<Int>()
		tree.insertData(3)
		tree.insertData(2)
		tree.insertData(1)

		print("\(tree)")

	}

	func testBinarySearchTreeInsertAndBalanceCheck2() {
		let tree = BinarySearchTree<Int>()
		tree.insertData(4)
		tree.insertData(2)
		tree.insertData(3)


		print("\(tree)")

	}

	func testBinarySearchTreeInsertAndBalanceCheck3() {
		let tree = BinarySearchTree<Int>()
		tree.insertData(5)
		tree.insertData(2)
		tree.insertData(3)
		tree.insertData(4)


		print("\(tree)")

	}



	static var allTests = [
		("testBinarySearchTreeLeftRotateTest", testBinarySearchTreeLeftRotateTest),
		("testBinarySearchTreeRightRotateTest", testBinarySearchTreeRightRotateTest),
		("testBinarySearchTreeInsertAndBalanceCheck1", testBinarySearchTreeInsertAndBalanceCheck1),
		("testBinarySearchTreeInsertAndBalanceCheck2", testBinarySearchTreeInsertAndBalanceCheck2),
		("testBinarySearchTreeInsertAndBalanceCheck3", testBinarySearchTreeInsertAndBalanceCheck3),
	]

}
