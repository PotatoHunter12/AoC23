import Foundation

let fileData = try Data(contentsOf: URL(fileURLWithPath: "input.txt"))
let input = String(data: fileData, encoding: .utf8)!.split(separator: "\n")
var ptss: Array<Int> = []

for line in input {
    let winner = line.split(separator: ": ")[1].split(separator: " | ")[0].split(separator: " ")
    let card = line.split(separator: ": ")[1].split(separator: " | ")[1].split(separator: " ")
    var pts = 0
    for num in card {
        if winner.contains(num) {
            pts += 1
        }
    }
    if pts == 0 { continue }
    ptss.append((pow(2,pts-1) as NSDecimalNumber).intValue)
}

var nevem: Array<Int> = [Int](repeating: 0,count:204)
for i in 0...203 {
    nevem[i] += 1
    let winner = Set(input[i].split(separator: ": ")[1].split(separator: " | ")[0].split(separator: " ").compactMap{ Int($0) })
    let card = Set(input[i].split(separator: ": ")[1].split(separator: " | ")[1].split(separator: " ").compactMap{ Int($0) })
    let intersect = winner.intersection(card)
    print(winner,card)
    print(i,intersect)
    if intersect.isEmpty { continue }
    for j in i+1...i+intersect.count{
        nevem[j] += nevem[i]
    }
}
print(nevem)

print("Answer 1:",ptss.reduce(0,+))
print("Answer 2:",nevem.reduce(0,+))