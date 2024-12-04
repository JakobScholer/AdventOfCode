import Foundation

func isSafeReport(_ levels: [Int]) -> Bool {
    let isIncreasing = levels[1] > levels[0]
    for i in 1..<levels.count {
        let diff = levels[i] - levels[i - 1]
        if abs(diff) < 1 || abs(diff) > 3 {
            return false
        }
        if (isIncreasing && diff < 0) || (!isIncreasing && diff > 0) {
            return false
        }
    }
    return true
}

func canBeSafeReport(_ levels: [Int]) -> Bool {
    for i in 0..<levels.count {
        var modifiedLevels = levels
        modifiedLevels.remove(at: i)
        if isSafeReport(modifiedLevels) {
            return true
        }
    }
    return false
}

let fileURL = URL(fileURLWithPath: "input.txt")
guard let input = try? String(contentsOf: fileURL) else {
    fatalError("Cannot read the input file")
}

let reports = input.split(separator: "\n").map { line in
    line.split(separator: " ").compactMap { Int($0) }
}
let safeReportsCountPartOne = reports.filter{ isSafeReport($0) }.count
let safeReportsCountPartTwo = reports.filter{ canBeSafeReport($0) }.count

print("Part 1: \(safeReportsCountPartOne)" )
print("Part 2: \(safeReportsCountPartTwo)" )