import Architecture

struct XCFramework: Command {
    var name: String { "xcframework" }
    var configuration: Configuration
    var library: Library
    var sdks: [SDK]
    
    func execute() throws {
        try launch(command: "mkdir", arguments: ["-p", "\(configuration.path)/xcframeworks"])
        try xcframework(path: configuration.path, library: library, sdks: sdks)
    }
    
    func xcframework(path: String, library: Library, sdks: [SDK]) throws {
        var arguments: [String] = ["-create-xcframework"]
        for sdk in sdks {
            arguments.append("-library \(path)/prepare/\(sdk.rawValue)/\(library.rawValue)/lib\(library.rawValue).a")
            arguments.append("-headers \(path)/prepare/\(sdk.rawValue)/\(library.rawValue)/include")
        }
        arguments.append("-output \(path)/xcframeworks/\(library.rawValue).xcframework")
        try launch(command: "/usr/bin/xcodebuild", arguments: arguments, path: path, redirect: true)
    }
    
    func lipo(library: Library, path: String, targets: [Platform]) throws {
        let map: (Platform) -> String = { platform in "\(configuration.path)/build/\(platform.rawValue)/\(platform.rawValue).a" }
        let arches: String = targets.map(map).joined(separator: " ")
        let arguments: [String] = [
            "libraries/\(library.rawValue)",
            "-create",
            arches,
            "-output"
        ]
        try launch(command: "/usr/bin/lipo", arguments: arguments, path: path)
    }
}
