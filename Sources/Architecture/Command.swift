public protocol Command {
    var name: String { get }
    func execute() async throws
}
