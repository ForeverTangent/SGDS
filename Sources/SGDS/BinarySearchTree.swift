//
//  SGDSBinarySearchTree.swift
//  SGDS
//
//  Created by Stanley Rosenbaum on 10/20/20.
//

import Foundation

class BSTNode<T: Comparable> {
	init(data: T) { self.data = data }
	var data: T
	var left: BSTNode<T>?
	var right: BSTNode<T>?

	public var height: Int {
		get {
			let theLeftHeight = left?.height ?? 0
			let theRightRight = right?.height ?? 0
			return max(theLeftHeight, theRightRight) + 1
		}
	}

}

extension BSTNode: CustomStringConvertible {
	var description: String {

		let theLeftDescription = left?.description ?? ""
		let theRightDescription = right?.description ?? ""

		return "value: \(self.data), left = [ \(theLeftDescription) ], right = [ \(theRightDescription) ]"
	}
}

/**
[Based off code here] (https://github.com/danmitu/BST/blob/master/Swift-BST/BST.swift)
// https://medium.com/swift-algorithms-data-structures/learning-advanced-binary-search-tree-algorithms-with-swift-c00588a638fe

*/
class BinarySearchTree<T: Comparable> {

	// MARK: - Properties

	private var root: BSTNode<T>?
	private var height: Int {
		guard let theRoot = root else { return 0 }
		return theRoot.height
	}

	private var isEmpty: Bool {
		get {
			guard root != nil else { return false }
			return true
		}
	}


	// MARK: - Class Methods


	public func containsNodeWith(_ data: T) -> Bool {
		guard getNodeWithData(data) != nil else { return false }
		return true
	}


	public func getNodeWithData(_ data: T) -> BSTNode<T>? {
		var current = root

		while let theNode = current {
			if theNode.data == data {
				return theNode
			}
			if data < theNode.data {
				current = theNode.left
			} else {
				current = theNode.right
			}
		}

		return nil
	}



	// MARK: Insert

	func insertData(_ data: T) {
		if let theRoot = root {
			root = insertData(data, into: theRoot)
		} else {
			root = BSTNode(data: data)
		}
	}


	private func insertData(_ data: T, into node: BSTNode<T>) -> BSTNode<T> {

		if data < node.data {
			if let theLeftNode = node.left {
				node.left = insertData(data, into: theLeftNode)
			} else {
				node.left = BSTNode(data: data)
			}
		} else if node.data < data {
			if let theRightNode = node.right {
				node.right = insertData(data, into: theRightNode)
			} else {
				node.right = BSTNode(data: data)
			}
		}

		let results = balanceNode(node)

		return results

	}


	private func removeData(_ data: T, from node: BSTNode<T>) -> BSTNode<T>? {
		guard let theNode = getNodeWithData(data) else { return nil }

		


		let results = balanceNode(theNode)

		return results
	}



	private func getBalanceFactorOfNode(_ node: BSTNode<T>) -> Int {

		let theLeftNodeHeight = node.left?.height ?? 0
		let theRightNodeHeight = node.right?.height ?? 0

		return theLeftNodeHeight - theRightNodeHeight
	}


	/**
	-------(1)                              (3)
	-----------\                           /     \
	-----------(3)        -->      (1)        (4)
	----------/      \                      \
	--------(2)       (4)                  (2)
	*/
	private func rotateLeft(_ node: BSTNode<T>) -> BSTNode<T> {

		guard let thePivot = node.right else { return node }

		node.right = thePivot.left
		thePivot.left = node

		return thePivot

	}


	/**
	------(4)                  (2)
	-------/                   /     \
	---(2)        -->  (1)         (4)
	---/    \                        /
	(1)    (3)                 (3)
	*/
	private func rotateRight(_ node: BSTNode<T>) -> BSTNode<T> {

		guard let thePivot = node.left else { return node }

		node.left = thePivot.right
		thePivot.right = node

		return thePivot

	}


	private func rotateRightLeft(_ node: BSTNode<T>) -> BSTNode<T> {
		guard let theRightChild = node.right else { return node }
		node.right = rotateRight(theRightChild)
		return rotateLeft(node)
	}


	private func rotateLeftRight(_ node: BSTNode<T>) -> BSTNode<T> {
		guard let theLeftChild = node.left else { return node }
		node.left = rotateLeft(theLeftChild)
		return rotateRight(node)
	}


	private func balanceNode(_ node: BSTNode<T>) -> BSTNode<T>  {

		let balanceFactor = getBalanceFactorOfNode(node)

		switch balanceFactor {
			case 2:
				if
					let theLeftChild = node.left,
				   	getBalanceFactorOfNode(theLeftChild) == -1 {
						return rotateLeftRight(node)
				} else {
					return rotateRight(node)
				}
			case -2:
				if
					let theRightChild = node.right,
					getBalanceFactorOfNode(theRightChild) == 1 {
						return rotateRightLeft(node)
				} else {
					return rotateLeft(node)
				}
			default:
				return node
		}

	}


	public func transverseInOrder(_ onVisit: (T)->Void) {
		traverseInOrder(root, onVisit)
	}


	private func traverseInOrder(_ node: BSTNode<T>?, _ onVisit: (T) -> Void) {
		guard let theNode = node else { return }
		traverseInOrder(theNode.left, onVisit)
		onVisit(theNode.data)
		traverseInOrder(theNode.right, onVisit)
	}


	public func transversePostOrder(_ onVisit: (T)->Void) {
		traversePostOrder(root, onVisit)
	}


	private func traversePostOrder(_ node: BSTNode<T>?, _ onVisit: (T) -> Void) {
		guard let theNode = node else { return }
		traversePostOrder(theNode.right, onVisit)
		onVisit(theNode.data)
		traversePostOrder(theNode.left, onVisit)
	}


	public func getMinimum() -> T? {
		return getMinimum(root)
	}


	private func getMinimum(_ node: BSTNode<T>?) -> T? {
		guard let theNode = node else { return nil }

		if let theLeftNode = theNode.left {
			return getMinimum(theLeftNode)
		}

		return theNode.data
	}


	public func getMaximum() -> T? {
		return getMaximum(root)
	}


	private func getMaximum(_ node: BSTNode<T>?) -> T? {
		guard let theNode = node else { return nil }

		if let theRightNode = theNode.right {
			return getMaximum(theRightNode)
		}

		return theNode.data
	}


	public func printAllInOrder() {
		var allData = [T]()
		transverseInOrder { (theData) in
			allData.append(theData)
		}
		print(allData)
	}

	public func printAllPostOrder() {
		var allData = [T]()
		transversePostOrder { (theData) in
			allData.append(theData)
		}
		print(allData)
	}

}


extension BinarySearchTree: CustomStringConvertible {
	var description: String {
		guard let theRoot = root else { return "" }
		return theRoot.description
	}
}


extension BinarySearchTree {

	#if DEBUG

	func testRotateLeftFromRoot() {
		guard let theRoot = root else { return }
		root = rotateLeft(theRoot)
	}


	func testRotateRightFromRoot() {
		guard let theRoot = root else { return }
		root = rotateRight(theRoot)
	}

	#endif
}

