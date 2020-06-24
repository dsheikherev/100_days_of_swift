import UIKit

var str = "Hello, playground"

let letter = str[str.index(str.startIndex, offsetBy: 3)]

let letter1 = str[3]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: 3)])
    }
}

let password = "PutinLoh"
let hasPrefix = password.hasPrefix("Putya")
let hasSuffix = password.hasSuffix("Loh")

extension String {
    func deletePrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        
        return String(self.dropFirst(prefix.count))
    }
    
    func deleteSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        
        return String(self.dropLast(suffix.count))
    }
}

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        
        return firstLetter.uppercased() + self.dropFirst()
    }
}

// challenge 1
extension String {
    func withPrefix(_ prefix: String) -> String {
        guard !self.hasPrefix(prefix) else { return self }
        
        return prefix + self
    }
}

// challenge 2
extension String {
    var isNumeric: Bool {
//        return Double(self) != nil
        if let num = Double(self) {
            print(num)
            return true
        }
        return false
    }
}

// challenge 3
extension String {
    var lines: [Substring] {
        return self.split(separator: "\n")
    }
}

let withPrefix = "carpet".withPrefix("car")
let numeric = "1.25e-2".isNumeric
assert("start from\nnew line\nNew line:".lines == ["start from", "new line", "New line:"], "Wrongly splitted string")


let input = "iOS developer is a job of my nearest future"
var hasString = input.contains("iOS")
hasString = input.lowercased().contains("ios")

let jobs = ["Python", "C", "iOS"]
let hasJob = jobs.contains(where: input.contains)

let string = "This will be NSAttributedString"
let attr: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]
let attrString = NSAttributedString(string: string)
let attributedString = NSMutableAttributedString(string: string)

attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))

print("\(attributedString.string)")
