#!/usr/bin/env xcrun --sdk macosx swift
// A build phase script for fetching, validating and generating a Swift wrapper over configuration files in iOS projects
// Source: https://github.com/pgorzelany/SwiftConfiguration

public struct ParsedArguments {
    public let configurationPlistFilePath: String
    public let outputFilePath: String
}

public class ArgumentsParser {

    public init() {}

    public func parseArguments(_ arguments: [String]) throws -> ParsedArguments {
        guard arguments.count == 3 else {
            throw ConfigurationError(message: "Insufficient number of arguments provided. Refer to the docs.")
        }

        return ParsedArguments(configurationPlistFilePath: arguments[1],
                               outputFilePath: arguments[2])
    }
}
public struct Configuration {
    
    let name: String
    let contents: Dictionary<String, Any>

    var allKeys: Set<String> {
        return Set(contents.keys)
    }
}
import Foundation

public struct ConfigurationError: LocalizedError {

    private let message: String

    init(message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}
import Foundation

public class ConfigurationManagerGenerator {

    // MARK: - Properties

    private let configurationPlistFilePath: String
    private let outputFilePath: String
    private let configurationKey: String
    private lazy var fileManager = FileManager.default

    // MARK: - Lifecycle

    public init(configurationPlistFilePath: String, outputFilePath: String, configurationKey: String) {
        self.outputFilePath = outputFilePath
        self.configurationKey = configurationKey
        self.configurationPlistFilePath = configurationPlistFilePath
    }

    // MARK: - Methods

    public func generateConfigurationManagerFile(for configurations: [Configuration], activeConfiguration: Configuration) throws {
        let template = ConfigurationManagerTemplate(configurations: configurations,
                                                    activeConfiguration: activeConfiguration,
                                                    configurationKey: configurationKey,
                                                    configurationPlistFilePath: configurationPlistFilePath)
        if fileManager.fileExists(atPath: outputFilePath) {
            try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
        } else {
            let outputFileUrl = URL(fileURLWithPath: outputFilePath)
            let outputFileDirectoryUrl = outputFileUrl.deletingLastPathComponent()
            try fileManager.createDirectory(at: outputFileDirectoryUrl, withIntermediateDirectories: true, attributes: nil)
            try template.configurationManagerString.write(toFile: outputFilePath, atomically: true, encoding: .utf8)
        }
    }
}
import Foundation

class ConfigurationManagerTemplate {

    private let configurationDictionaryFileName: String
    private let configurationKey: String
    private let configurations: [Configuration]
    private let activeConfiguration: Configuration
    private lazy var configurationsString = generateConfigurationsString()
    private lazy var configurationsKeysString = generateConfigurationKeysString()
    private lazy var configurationPropertiesString = generateConfigurationPropertiesString()

    lazy var configurationManagerString = #"""
    // This file is autogenerated. Do not modify!
    // Generated by https://github.com/pgorzelany/SwiftConfiguration

    import Foundation

    public final class Environment {

        public enum Configuration: String, CaseIterable {
            \#(configurationsString)
        }

        public enum ConfigurationKey: String, CaseIterable {
            \#(configurationsKeysString)
        }

        // MARK: Shared instance

        public static let current = Environment()

        // MARK: Properties

        private let configurationKey = "\#(configurationKey)"
        private let configurationPlistFileName = "\#(configurationDictionaryFileName)"
        private let activeConfigurationDictionary: NSDictionary
        public let activeConfiguration: Configuration
    
        public var baseURL: URL {
            guard let url = URL(string: Environment.current.baseURLString) else {
                fatalError("Base URL is not valid")
            }
            return url
        }
        \#(configurationPropertiesString)
        // MARK: Lifecycle

        public init(targetConfiguration: Configuration? = nil) {
            let bundle = Bundle(for: Environment.self)
            guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String,
                let configurationDictionaryPath = bundle.path(forResource: configurationPlistFileName, ofType: nil),
                let activeConfiguration = targetConfiguration ?? Configuration(rawValue: rawConfiguration),
                let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath),
                let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary
                else {
                    fatalError("Configuration Error")

            }
            self.activeConfiguration = activeConfiguration
            self.activeConfigurationDictionary = activeEnvironmentDictionary
        }

        // MARK: Methods

        public func value<T>(for key: ConfigurationKey) -> T {
            guard let value = activeConfigurationDictionary[key.rawValue] as? T else {
                fatalError("No value satysfying requirements")
            }
            return value
        }

        public func isRunning(in configuration: Configuration) -> Bool {
            return activeConfiguration == configuration
        }
    }
    """#

    init(configurations: [Configuration], activeConfiguration: Configuration, configurationKey: String, configurationPlistFilePath: String) {
        self.configurations = configurations
        self.activeConfiguration = activeConfiguration
        self.configurationKey = configurationKey
        self.configurationDictionaryFileName = (configurationPlistFilePath as NSString).lastPathComponent
    }

    func generateConfigurationsString() -> String {
        var configurationsString = ""
        let sortedConfigurations = configurations.sorted(by: {$0.name <= $1.name})
        for configuration in sortedConfigurations {
            let sanitizedConfigurationName = configuration.name
                .components(separatedBy: CharacterSet.letters.inverted)
                .joined()
            configurationsString += "case \(sanitizedConfigurationName) = \"\(configuration.name)\"\n\t\t"
        }
        return configurationsString
    }

    func generateConfigurationKeysString() -> String {
        var configurationsKeysString = ""
        let allKeys = Set(configurations.flatMap { $0.allKeys })
        for key in allKeys.sorted() {
            configurationsKeysString += "case \(key)\n\t\t"
        }
        return configurationsKeysString
    }

    func generateConfigurationPropertiesString() -> String {
        var configurationPropertiesString = ""
        let sortedContents = activeConfiguration.contents
            .sorted(by: {$0.key <= $1.key})
        for (key, value) in sortedContents {
            configurationPropertiesString += """

            \tvar \(key): \(getPlistType(for: value)) {
            \t\treturn value(for: .\(key))
            \t}\n
            """
        }
        return configurationPropertiesString
    }
}

private func getPlistType<T>(for value: T) -> String {
    if value is String {
        return "String"
    } else if let numberValue = value as? NSNumber {
        let boolTypeId = CFBooleanGetTypeID()
        let valueTypeId = CFGetTypeID(numberValue)
        if boolTypeId == valueTypeId {
            return "Bool"
        } else if value is Int {
            return "Int"
        } else if value is Double {
            return "Double"
        }
        fatalError("Unsuported type")
    } else if value is Date {
        return "Date"
    } else {
        fatalError("Unsuported type")
    }
}
import Foundation

public class ConfigurationProvider {

    public init() {}

    // MARK: Methods

    public func getConfigurations(at configurationPlistFilePath: String) throws -> [Configuration] {
        guard let configurationsDictionary = NSDictionary(contentsOfFile: configurationPlistFilePath) else {
            throw ConfigurationError(message: "Could not load configuration dictionary at: \(configurationPlistFilePath)")
        }

        return try configurationsDictionary.map { configurationDictionary -> Configuration in
            print(configurationDictionary)
            guard let name = configurationDictionary.key as? String, let contents = configurationDictionary.value as? Dictionary<String, Any> else {
                throw ConfigurationError(message: "The configuration file has invalid format. Please refer to the docs.")
            }

            return Configuration(name: name, contents: contents)
        }
    }

    public func getConfiguration(at configurationPlistFilePath: String, for configurationName: String) throws -> Configuration {
        let configurations = try getConfigurations(at: configurationPlistFilePath)
        guard let configuration = configurations.first(where: { $0.name == configurationName }) else {
            throw ConfigurationError(message: "Could not get configuration dictionary for configurationName: \(configurationName)")
        }

        return configuration
    }
}

public class ConfigurationValidator {

    private let messagePrinter: MessagePrinter

    public init(messagePrinter: MessagePrinter) {
        self.messagePrinter = messagePrinter
    }

    // MARK: - Public Methods

    public func validateConfigurations(_ configurations: [Configuration], activeConfigurationName: String) throws {
        let allKeys = configurations.reduce(Set<String>(), { (result, configuration) -> Set<String> in
                return result.union(configuration.allKeys)
            })
        for configuration in configurations {
            let difference = allKeys.subtracting(configuration.allKeys)
            if !difference.isEmpty {
                for key in difference {
                    messagePrinter.printWarning("Missing key: \(key) in configuration: \(configuration.name)")
                }
            }
        }

        let configurationNames = configurations.map({$0.name})
        guard configurationNames.contains(where: {$0 == activeConfigurationName}) else {
            throw ConfigurationError(message: "The configuration file does not contain a configuration for the active configuration (\(activeConfigurationName))")
        }
    }
}
import Foundation

public struct Environment {
    public let plistFilePath: String
    public let activeConfigurationName: String
}

public class EnvironmentParser {

    public init() {}

    private let processEnvironemnt = ProcessInfo.processInfo.environment

    public func parseEnvironment() throws -> Environment {
        guard let activeConfigurationName = processEnvironemnt["CONFIGURATION"] else {
            throw ConfigurationError(message: "Could not obtain the active configuration from the environment variables")
        }

        guard let projectDirectory = processEnvironemnt["PROJECT_DIR"] else {
            throw ConfigurationError(message: "Could not obtain the PROJECT_DIR path from the environment variables")
        }

        guard let relativePlistFilePath = processEnvironemnt["INFOPLIST_FILE"] else {
            throw ConfigurationError(message: "Could not obtain the INFOPLIST_FILE path from the environment variables")
        }

        let plistFilePath = "\(projectDirectory)/\(relativePlistFilePath)"

        return Environment(plistFilePath: plistFilePath, activeConfigurationName: activeConfigurationName)
    }
}

public class MessagePrinter {

    public init() {}

    /// The warning will show up in compiler build time warnings
    public func printWarning(_ items: Any...) {
        for item in items {
            print("warning: \(item)")
        }
    }

    /// The error will show up in compiler build time errors
    public func printError(_ items: Any...) {
        for item in items {
            print("error: \(item)")
        }
    }
}

import Foundation

/// Modifies the plist file by adding the configuration key
/// The value indicates the current runtime configuration
public class PlistModifier {

    // MARK: - Properties

    private let plistFilePath: String
    private let configurationKey: String
    private let configurationValue = "$(CONFIGURATION)"
    private let plistBuddyPath = "/usr/libexec/PlistBuddy"

    // MARK: - Lifecycle

    public init(plistFilePath: String, configurationKey: String) {
        self.plistFilePath = plistFilePath
        self.configurationKey = configurationKey
    }

    // MARK: - Methods

    public func addOrSetConfigurationKey() throws {
        if invokeShell(with: plistBuddyPath, "-c", "Add :\(configurationKey) string \(configurationValue)", "\(plistFilePath)") != 0 {
            guard invokeShell(with: plistBuddyPath, "-c", "Set :\(configurationKey) \(configurationValue)", "\(plistFilePath)") == 0 else {
                throw ConfigurationError(message: "Could not modify InfoPlist file")
            }
        }
    }

    private func invokeShell(with args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
import Foundation


private let environment = ProcessInfo.processInfo.environment
private let printer = MessagePrinter()
private let environmentParser = EnvironmentParser()
private let argumentsParser = ArgumentsParser()
private let configurationProvider = ConfigurationProvider()
private let configurationValidator = ConfigurationValidator(messagePrinter: printer)
private let configurationKey = "Environment.currentConfiguration"

do {
    let environment = try environmentParser.parseEnvironment()
    let arguments = try argumentsParser.parseArguments(CommandLine.arguments)
    let infoPlistModifier = PlistModifier(plistFilePath: environment.plistFilePath, configurationKey: configurationKey)
    let configurationManagerGenerator = ConfigurationManagerGenerator(configurationPlistFilePath: arguments.configurationPlistFilePath,
                                                                      outputFilePath: arguments.outputFilePath,
                                                                      configurationKey: configurationKey)
    let configurations = try configurationProvider.getConfigurations(at: arguments.configurationPlistFilePath)
    try configurationValidator.validateConfigurations(configurations, activeConfigurationName: environment.activeConfigurationName)
    try infoPlistModifier.addOrSetConfigurationKey()
    let activeConfiguration = try configurationProvider.getConfiguration(at: arguments.configurationPlistFilePath, for: environment.activeConfigurationName)
    try configurationManagerGenerator.generateConfigurationManagerFile(for: configurations, activeConfiguration: activeConfiguration)
    exit(0)
} catch {
    printer.printError(error.localizedDescription)
    exit(0)
}
