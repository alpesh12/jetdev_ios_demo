//
//  PasswordValidator.swift
//  JetDevsHomeWork
//
//  Created by Avruti on 09/12/22.
//

import Foundation

final class PasswordValidator {

    func validate(_ input: String) -> Bool {
        guard
            let regex = try? NSRegularExpression(
                pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$",
                options: []
            )
        else {
            assertionFailure("Regex not valid")
            return false
        }

        let regexFirstMatch = regex
            .firstMatch(
                in: input,
                options: [],
                range: NSRange(location: 0, length: input.count)
            )

        return regexFirstMatch != nil
    }
}
