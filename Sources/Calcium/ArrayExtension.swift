//
//  ArrayExtension.swift
//  Calcium-iOS
//
//  Created by Filip Šašala on 02/03/2023.
//

extension Array {

    func contains(index: Int) -> Bool {
        return (startIndex..<endIndex).contains(index)
    }

    subscript(safe index: Int) -> Element? {
        self.contains(index: index) ? self[index] : nil
    }

}

