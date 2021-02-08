//
//  SGDSBinarySearchTree.swift
//  SGDS
//
//  Created by Stanley Rosenbaum on 10/20/20.
//

import Foundation

class BinarySearchTreeNode<T: Comparable> {
	init(data: T) { self.data = data }
	var data: T
	var leftChild: BinarySearchTreeNode<T>?
	var rightChild: BinarySearchTreeNode<T>?


	public var height: Int {
		get {
			let theLeftHeight = leftChild?.height ?? 0
			let theRightRight = rightChild?.height ?? 0
			return max(theLeftHeight, theRightRight) + 1
		}
	}

	public var balanceFactor: Int {
		leftHeight - rightHeight
	}

	public var leftHeight: Int {
		leftChild?.height ?? -1
	}

	public var rightHeight: Int {
		rightChild?.height ?? -1
	}

}

extension BinarySearchTreeNode: CustomStringConvertible {
	var description: String {

		let theLeftDescription = leftChild?.description ?? ""
		let theRightDescription = rightChild?.description ?? ""

		return "value: \(self.data), left = [ \(theLeftDescription) ], right = [ \(theRightDescription) ]"
	}
}

/**
[Based off code here] (https://github.com/danmitu/BST/blob/master/Swift-BST/BST.swift)
// https://medium.com/swift-algorithms-data-structures/learning-advanced-binary-search-tree-algorithms-with-swift-c00588a638fe

*/
class BinarySearchTree<T: Comparable> {

	// MARK: - Properties

	private var root: BinarySearchTreeNode<T>?
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


	private var opCount = 0
	private var opCountLimit = 5


	// INIT: =


	// MARK: - Class Methods

	// MARK: Insert

	func insertData(_ data: T) {
		if let theRoot = root {
			root = insertData(data, into: theRoot)
		} else {
			root = BinarySearchTreeNode(data: data)
		}
	}

	private func insertData(_ data: T, into node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T> {

		if data < node.data {
			if let theLeftNode = node.leftChild {
				node.leftChild = insertData(data, into: theLeftNode)
			} else {
				node.leftChild = BinarySearchTreeNode(data: data)
			}
		} else if node.data < data {
			if let theRightNode = node.rightChild {
				node.rightChild = insertData(data, into: theRightNode)
			} else {
				node.rightChild = BinarySearchTreeNode(data: data)
			}
		}

		let results = balanceNode(node)

		return results

	}


	private func getBalanceFactorOfNode(_ node: BinarySearchTreeNode<T>) -> Int {

		let theLeftNodeHeight = node.leftChild?.height ?? 0
		let theRightNodeHeight = node.rightChild?.height ?? 0

		return theLeftNodeHeight - theRightNodeHeight
	}




	/**
	-------(1)                              (3)
	-----------\                           /     \
	-----------(3)        -->      (1)        (4)
	----------/      \                      \
	--------(2)       (4)                  (2)
	*/
	private func rotateLeft(_ node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T> {

		guard let thePivot = node.rightChild else { return node }

		node.rightChild = thePivot.leftChild
		thePivot.leftChild = node

		return thePivot

	}

	/**
	------(3)                  (2)
	-------/                   /     \
	---(2)        -->  (1)         (3)
	---/
	(1)
	*/
	private func rotateRight(_ node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T> {

		guard let thePivot = node.leftChild else { return node }

		node.leftChild = thePivot.rightChild
		thePivot.rightChild = node

		return thePivot

	}


	private func rotateRightLeft(_ node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T> {
		guard let theRightChild = node.rightChild else { return node }
		node.rightChild = rotateRight(theRightChild)
		return rotateLeft(node)
	}


	private func rotateLeftRight(_ node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T> {
		guard let theLeftChild = node.leftChild else { return node }
		node.leftChild = rotateLeft(theLeftChild)
		return rotateRight(node)
	}



	private func balanceNode(_ node: BinarySearchTreeNode<T>) -> BinarySearchTreeNode<T>  {

		let balanceFactor = getBalanceFactorOfNode(node)

		switch balanceFactor {
			case 2:
				if
					let theLeftChild = node.leftChild,
				   	getBalanceFactorOfNode(theLeftChild) == -1 {
						return rotateLeftRight(node)
				} else {
					return rotateRight(node)
				}
			case -2:
				if
					let theRightChild = node.rightChild,
					getBalanceFactorOfNode(theRightChild) == 1 {
						return rotateRightLeft(node)
				} else {
					return rotateLeft(node)
				}
			default:
				return node
		}

	}


	public func printAllInOrder() {
		var allData = [T]()
		transverseInOrder { (theData) in
			allData.append(theData)
		}
		print(allData)
	}

	public func transverseInOrder(_ onVisit: (T)->Void) {
		traverseInOrder(root, onVisit)
	}

	private func traverseInOrder(_ node: BinarySearchTreeNode<T>?, _ onVisit: (T) -> Void) {
		guard let theNode = node else { return }
		traverseInOrder(theNode.leftChild, onVisit)
		onVisit(theNode.data)
		traverseInOrder(theNode.rightChild, onVisit)
	}

	public func printAllPostOrder() {
		var allData = [T]()
		transversePostOrder { (theData) in
			allData.append(theData)
		}
		print(allData)
	}


	public func transversePostOrder(_ onVisit: (T)->Void) {
		traversePostOrder(root, onVisit)
	}

	private func traversePostOrder(_ node: BinarySearchTreeNode<T>?, _ onVisit: (T) -> Void) {
		guard let theNode = node else { return }
		traversePostOrder(theNode.rightChild, onVisit)
		onVisit(theNode.data)
		traversePostOrder(theNode.leftChild, onVisit)
	}


	func getMinimum() -> T? {
		return getMinimum(root)
	}

	private func getMinimum(_ node: BinarySearchTreeNode<T>?) -> T? {
		guard let theNode = node else { return nil }

		if let theLeftNode = theNode.leftChild {
			return getMinimum(theLeftNode)
		}

		return theNode.data
	}

	func getMaximum() -> T? {
		return getMaximum(root)
	}

	private func getMaximum(_ node: BinarySearchTreeNode<T>?) -> T? {
		guard let theNode = node else { return nil }

		if let theRightNode = theNode.rightChild {
			return getMaximum(theRightNode)
		}

		return theNode.data
	}


	private func rebalance(_ node: BinarySearchTreeNode<T>?) {

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

