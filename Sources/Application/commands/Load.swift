import Architecture

struct Load: Command {
    var name: String { "load" }
    var configuration: Configuration
    var library: Library
    var sdks: [SDK]
    
    func execute() async throws {
        for sdk in sdks {
            try load(path: configuration.path, library: library, sdk: sdk)
            print("load success", sdk.rawValue)
        }
    }
    
    private func load(path: String, library: Library, sdk: SDK) throws {
        let tmp = "/tmp/tool"
        let url = library.source
        let libraries = "\(path)/libraries/\(sdk.rawValue)"
        let path = "/\(libraries)/\(library)"
        try launch(command: "mkdir", arguments: ["-p", libraries])
        try launch(command: "mkdir", arguments: [tmp])
        try launch(command: "curl", arguments: ["-L \(url) | tar xjC \(tmp)"])
        try launch(command: "mv", arguments: ["\(tmp)/*", path])
        try launch(command: "rmdir", arguments: [tmp])
    }
}
