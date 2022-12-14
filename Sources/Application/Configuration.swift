struct Configuration {
    let path: String
    
    init() throws {
        var path: [String] = #file.split(separator: "/").map(String.init)
        path.removeLast()
        path.removeLast()
        path.removeLast()
        self.path = "/" + path.joined(separator: "/")
    }
}
