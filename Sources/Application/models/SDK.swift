enum SDK: String {
    case macosx, iphoneos, iphonesimulator, appletvos, appletvsimulator, watchos, watchsimulator
    
    func path() async -> String {
        await output(command: "xcrun", arguments: ["--sdk", rawValue, "--show-sdk-path"])
    }
    
    var architectures: [String] {
        switch self {
        case .macosx: return ["x86_64", "arm64"]
        case .iphoneos: return ["arm64"]
        case .iphonesimulator: return ["x86_64", "arm64"]
        case .appletvos: return ["arm64"]
        case .appletvsimulator: return ["x86_64", "arm64"]
        case .watchos: return ["arm64"]
        case .watchsimulator: return ["x86_64", "arm64"]
        }
    }
    
    var target: String? {
        switch self {//arm64/arm64e only, no armv7/armv7s support
        case .macosx: return "10.13"
        case .iphoneos: return "11.0"
        case .iphonesimulator: return "11.0"
        case .appletvos: return "10"
        case .appletvsimulator: return "10"
        case .watchos: return "10"
        case .watchsimulator: return "9.0"
        }
    }
}
