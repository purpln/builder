import Architecture

struct Clear: Command {
    var name: String { "clear" }
    var configuration: Configuration
    
    func execute() throws {
        try launch(command: "rm", arguments: ["-rf", "/tmp/tool"])
        try launch(command: "rm", arguments: ["-rf", "libraries"], path: configuration.path)
        try launch(command: "rm", arguments: ["-rf", "prepare"], path: configuration.path)
        try launch(command: "rm", arguments: ["-rf", "xcframework"], path: configuration.path)
        print("clear success")
    }
}
