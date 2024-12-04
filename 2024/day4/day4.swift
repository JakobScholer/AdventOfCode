import Foundation

func readInputFile() -> [[Character]] {
    let fileURL = URL(fileURLWithPath: "input.txt")
    do {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        let lines = content.split(separator: "\n")
        return lines.map { Array($0) }
    } catch {
        fatalError("Failed to read input file: \(error)")
    }
}

func checkXMASPattern(grid: [[Character]], startX: Int, startY: Int) -> Bool {
    if leftLine(grid: grid, startX: startX, startY: startY) &&
       rightLine(grid: grid, startX: startX, startY: startY) {
        return true
    }
    return false
}

func leftLine(grid: [[Character]], startX: Int, startY: Int) -> Bool {
    if grid[startX][startY] == "M" &&
       grid[startX + 1][startY + 1] == "A" &&
       grid[startX + 2][startY + 2] == "S" {
        return true
    } else if grid[startX][startY] == "S" &&
              grid[startX + 1][startY + 1] == "A" &&
              grid[startX + 2][startY + 2] == "M" {
        return true
    }
    return false
}

func rightLine(grid: [[Character]], startX: Int, startY: Int) -> Bool {
    if grid[startX + 2][startY] == "M" &&
       grid[startX + 1][startY + 1] == "A" &&
       grid[startX][startY + 2] == "S" {
        return true
    } else if grid[startX + 2][startY] == "S" &&
              grid[startX + 1][startY + 1] == "A" &&
              grid[startX][startY + 2] == "M" {
        return true
    }
    return false
}

func countXMASPatterns(grid: [[Character]]) -> Int {
    var count = 0
    for x in 0..<grid.count-2 {
        for y in 0..<grid[0].count-2 {
            if checkXMASPattern(grid: grid, startX: x, startY: y) {
                count += 1
            }
        }
    }
    return count
}

let grid = readInputFile()
let occurrences = countXMASPatterns(grid: grid)
print("X-MAS patterns: \(occurrences)")
