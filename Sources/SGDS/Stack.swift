//
//  SGDSStack.swift
//  SGDS
//
//  Created by Stanley Rosenbaum on 10/20/20.
//

import Foundation

class Stack<E> {
	var items  = [E]()

	func push(_ item: E) {
		items.append(item)
	}

	func pop() -> E? {
		return items.removeLast()
	}

	func peak() -> E? {
		return items.last
	}

	func count() -> Int {
		return items.count
	}

	var isEmpty: Bool {
		get {
			return items.isEmpty
		}
	}

	func clear() {
		items.removeAll()
	}
}


extension Stack: CustomStringConvertible {
	var description: String {
		get {
			var returnString = "TOP, "
			// Reversed because it is a stack.
			for element in items.reversed() {
				returnString.append("\(element), ")
			}
			returnString.append("BOTTOM")
			return returnString
		}
	}

	func printStack() {
		print(description)
	}

}
