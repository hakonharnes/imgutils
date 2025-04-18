import ArgumentParser
import Common

let VERSION = "0.1.0"

@main
struct CopyCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "imgcopy",
        abstract: "Copy an image to the clipboard"
    )

    @Option(
        name: .shortAndLong,
        help: ArgumentHelp("Input file path. Reads from standard input if omitted.", valueName: "file")
    )
    var input: String?

    @Flag(name: [.customShort("V"), .long], help: ArgumentHelp("Show the version."))
    var version = false

    func run() throws {
        if version {
            print(VERSION)
            return
        }
    }
}
