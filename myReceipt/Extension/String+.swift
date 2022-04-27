//
//  String+.swift
//  myReceipt
//
//  Created by 姜宗暐 on 2022/4/26.
//

import Foundation

extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with: Range<Int>) -> String {
        let startIndex = index(from: with.lowerBound)
        let endIndex = index(from: with.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
