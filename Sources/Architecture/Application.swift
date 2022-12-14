public protocol Application {
    associatedtype Content: Sequence<any Command>
    var commands: Content { get }
    
    init() async throws
    static func main() async throws
}

extension Application {
    public static func main() async throws {
        var core = try await Core(Self.self)
        await core.execute()
    }
}
