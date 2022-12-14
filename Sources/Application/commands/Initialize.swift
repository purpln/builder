import Architecture

struct Initialize: Command {
    var name: String { "initialize" }
    
    func execute() throws {
        _ = try GasPreprocessor()
        let brew = try Homebrew()
        try brew.install("cmake")
        try brew.install("yasm")
        try brew.install("nasm")
    }
}
