import UIKit

let name = "Taylor"

for letter in name {
    print(letter)
}

let letter = name[name.index(name.startIndex, offsetBy: 3)]

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

let letter2 = name[2]

let password = "123456"

password.hasPrefix("123")

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasPrefix(suffix) else { return self }
        return String(self.dropFirst(suffix.count))
    }
    
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

let languages = ["Swift", "Python", "Ruby"]

let str = "Swift is like Objective-C whithout a C"

// para quando retorna true, se nao achar retorna false
languages.contains(where: str.contains)

let string = "This is a test string"

let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString = NSAttributedString(string: string, attributes: attributes)

let attributedString2 = NSMutableAttributedString(string: string, attributes: nil)

attributedString2.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 6))

// challenges
extension String {
    func withPrefix(_ prefix: String) -> String {
        return self.contains(prefix) ? self : prefix + self
    }
    var isNumeric: Bool {
//        return Int(self) != nil ? true : false
        return ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"].contains(where: self.contains)
    }
    
    var lines: [String] {
        return self.components(separatedBy: "\n")
    }
}

let stringPrefix = "dog"
stringPrefix.withPrefix("cat")
stringPrefix.withPrefix("dog")

let numericString = "1asd"
numericString.isNumeric
Int(numericString)

let lineBreakString = "This \n is \n nice"
print(lineBreakString)
lineBreakString.lines
