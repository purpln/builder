enum Library: String, Equatable {
    case leveldb
    
    var source: String {
        switch self {
        case .leveldb: return "https://github.com/google/leveldb/archive/refs/tags/1.23.zip"
        }
    }
}


extension Library {
    func build(path: String, sdk: SDK) async throws {
        switch self {
        case .leveldb:
            let prepare = "\(path)/prepare/\(sdk)/\(rawValue)"
            let libraries = "\(path)/libraries/\(sdk)/\(rawValue)"
            let cmake = "/opt/homebrew/bin/cmake"
            
            let sdkPath = await sdk.path()
            var additional = ["-S .", "-B .", "-DCMAKE_OSX_SYSROOT=\(sdkPath)"]
            
            if sdk.architectures.count != 0 {
                additional.append("-DCMAKE_OSX_ARCHITECTURES=" + sdk.architectures.joined(separator: #"\;"#))
            }
            if let target = sdk.target {
                additional.append("-DCMAKE_OSX_DEPLOYMENT_TARGET=" + target)
            }
            try launch(command: "mkdir", arguments: ["-p", "\(prepare)/include"])
            try launch(command: cmake, arguments: additional + arguments, path: libraries, environment: environment, redirect: true)
            try launch(command: cmake, arguments: ["--build ."], path: libraries, environment: [:], redirect: true)
            try launch(command: "cp", arguments: ["-rf", "\(libraries)/include/*", "\(prepare)/include"])
            try launch(command: "cp", arguments: ["-rf", "\(libraries)/libleveldb.a", prepare])
        }
    }
}

extension Library {
    var arguments: [String] {
        switch self {
        case .leveldb:
            return [
                "-DLEVELDB_BUILD_BENCHMARKS=OFF",
                "-DLEVELDB_BUILD_TESTS=OFF",
                "-DCMAKE_BUILD_TYPE=Release .."
            ]
        }
    }
    var environment: [String: String] {
        switch self {
        case .leveldb:
            return [
                "LEVELDB_IS_BIG_ENDIAN":"0",
                "LEVELDB_PLATFORM_POSIX":"1",
            ]
        }
    }
}

extension Library {
    var scheme: String {
        switch self {
        case .leveldb: return "LevelDB"
        }
    }
}
