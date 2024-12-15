import Foundation

extension Array where Iterator.Element == Bool {
    var allTrue: Bool {
        return !contains { !$0 }
    }

    var allFalse: Bool {
        return !contains { $0 }
    }

    var anyTrue: Bool {
        return !allFalse
    }

    var anyFalse: Bool {
        return !allTrue
    }
}
