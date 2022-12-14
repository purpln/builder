struct Core {
    private var application: any Application
    private var executing: Bool = true
    
    mutating func execute() async {
        var commands: [String: Command] = [:]
        for command in application.commands as any Sequence {
            guard let command = command as? Command else { continue }
            commands[command.name] = command
        }
        repeat {
            do {
                guard let string = readLine() else { return }
                guard let command = commands[string] else { return }
                try await command.execute()
            } catch {
                print(error)
            }
        } while executing
    }
    
    init<T>(_ t: T.Type) async throws where T: Application {
        application = try await T()
    }
}
