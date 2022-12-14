import Architecture

@main
struct App: Application {
    let configuration: Configuration
    let library: Library = .leveldb
    let sdks: [SDK] = [.iphoneos, .iphonesimulator]
    
    var commands: [any Command] { [
        Load(configuration: configuration, library: library, sdks: sdks),
        Build(configuration: configuration, library: library, sdks: sdks),
        XCFramework(configuration: configuration, library: library, sdks: sdks),
        Clear(configuration: configuration),
        Test(configuration: configuration)
    ] }
    
    init() throws {
        configuration = try Configuration()
    }
}
