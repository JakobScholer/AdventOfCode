import Foundation

func calculateMulSum(from input: String) -> Int {
    let mulRegex = try! NSRegularExpression(pattern: #"mul\((\d+),(\d+)\)"#)
    let doRegex = try! NSRegularExpression(pattern: #"do\(\)"#)
    let dontRegex = try! NSRegularExpression(pattern: #"don't\(\)"#)
    let nsrange = NSRange(input.startIndex..<input.endIndex, in: input)
    
    let doMatches = doRegex.matches(in: input, options: [], range: nsrange)
    let dontMatches = dontRegex.matches(in: input, options: [], range: nsrange)
    let allMatches = (doMatches.map { ($0.range.location, "do") } + dontMatches.map { ($0.range.location, "don't") }).sorted { $0.0 < $1.0 }
    
    var sum = 0
    var isEnabled = true
    mulRegex.enumerateMatches(in: input, options: [], range: nsrange) { match, _, _ in
        if let match = match,
           let xRange = Range(match.range(at: 1), in: input),
           let yRange = Range(match.range(at: 2), in: input) {
            let x = Int(input[xRange])!
            let y = Int(input[yRange])!
            
            for (position, instruction) in allMatches {
                if position > match.range.location {
                    break
                }
                if instruction == "do" {
                    isEnabled = true
                } else if instruction == "don't" {
                    isEnabled = false
                }
            }
            
            if isEnabled {
                sum += x * y
            }
        }
    }
    
    return sum
}

let fileURL = URL(fileURLWithPath: "input.txt")
guard let input = try? String(contentsOf: fileURL) else {
    fatalError("Cannot read the input file")
}

let result = calculateMulSum(from: input)
print("Total mul instructions: \(result).")