extension String {
    func remove(_ target: Character) -> String {
        String(compactMap { character in character == target ? nil : character })
    }
}

/*
extension String {
    func replacing<Target, Replacement>(of target: Target, with replacement: Replacement) -> String where Target : StringProtocol, Replacement : StringProtocol {
        var matches: [Range<Index>] = []
        var crange: Range<Index> = startIndex..<endIndex
        
        while !crange.isEmpty {
            range(of: target)
        }
        
        var res = self
        for range in matches.sorted(by: { $0.lowerBound > $1.lowerBound }) {
            res.replaceSubrange(range, with: replacement)
        }
        return res
    }
}
*/

/*
extension String {
    func replacing(_ oldString: String, with newString: String) -> String {

        guard !oldString.isEmpty, !newString.isEmpty else { return self }

        let charArray = Array(self.characters)
        let oldCharArray = Array(oldString.characters)
        let newCharArray = Array(newString.characters)

        var matchedChars = 0
        var resultCharArray = [Character]()

        for char in charArray {
            if char == oldCharArray[matchedChars] {
                matchedChars += 1
                if matchedChars == oldCharArray.count {
                    resultCharArray.append(contentsOf: newCharArray)
                    matchedChars = 0
                }
            } else {
                for i in 0 ..< matchedChars {
                    resultCharArray.append(oldCharArray[i])
                }
                if char == oldCharArray[0] {
                    matchedChars = 1
                } else {
                    matchedChars = 0
                    resultCharArray.append(char)
                }
            }
        }

        return String(resultCharArray)

    }
}
*/
