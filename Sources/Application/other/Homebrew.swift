struct Homebrew {
    func install(_ command: String) throws {
        if !bool(command: command) {
            print("'\(command)' not found")
            print("installing '\(command)'...")
            try launch(command: "brew", arguments: ["install", command])
        }
    }
    
    init() throws {
        if !bool(command: "brew") {
            print("'brew' not found")
            print("installing 'Homebrew'...")
            let command = #"/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)""#
            try launch(command: command)
        }
    }
}
