import Foundation

func readData(from input: String) -> ([Int], [Int])? {
    do {
        let content = try String(contentsOfFile: file)
        let lines = content.split(separator: "\n")
        var leftList = [Int]()
        var rightList = [Int]()
        
        for line in lines {
            let numbers = line.split(separator: "   ").compactMap { Int($0) }
            if numbers.count == 2 {
                leftList.append(numbers[0])
                rightList.append(numbers[1])
            }
        }
        return (leftList, rightList)
    } catch {
        print("Error reading file: \(error)")
        return nil
    }
}

// Function to calculate the total distance between two lists
func calculateTotalDistance(leftList: [Int], rightList: [Int]) -> Int {
    let sortedLeftList = leftList.sorted()
    let sortedRightList = rightList.sorted()

    var totalCount = 0
    for number in sortedLeftList {
        let occurrences = sortedRightList.filter { $0 == number }.count
        totalCount += occurrences * number
    }
    print(totalCount)
    
    
    var totalDistance = 0
    for (left, right) in zip(sortedLeftList, sortedRightList) {
        totalDistance += abs(left - right)
    }
    
    return totalDistance
}

let fileURL = URL(fileURLWithPath: "input.txt")
guard let input = try? String(contentsOf: fileURL) else {
    fatalError("Cannot read the input file")
}
    
if let (leftList, rightList) = readData(from: input) {
    let totalDistance = calculateTotalDistance(leftList: leftList, rightList: rightList)
    print("Total distance: \(totalDistance)")
} else {
    print("Failed to read data from file.")
}