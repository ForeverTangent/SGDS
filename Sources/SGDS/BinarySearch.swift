//
//  SGDSBinarySearch.swift
//  SGDS
//
//  Created by Stanley Rosenbaum on 10/20/20.
//

import Foundation

/**
Just a function.
*/
func BinarySearch<T: Comparable>(array: [T], forTarget target: T) -> Int {

	if array.count == 0 { return -1 }

	var range = 0..<array.count

	while range.lowerBound < range.upperBound {
		let middle = range.lowerBound + (range.upperBound - range.lowerBound) / 2

		if array[middle] == target {
			return middle
		}

		if array[middle] < target {
			range = middle + 1..<range.upperBound
		} else {
			range = range.lowerBound..<middle
		}
	}

	return -1
}
