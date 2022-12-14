import Architecture

struct Build: Command {
    var name: String { "build" }
    var configuration: Configuration
    var library: Library
    var sdks: [SDK]
    
    func execute() async throws {
        for sdk in sdks {
            try await library.build(path: configuration.path, sdk: sdk)
            print("build success", sdk.rawValue)
        }
    }
}
