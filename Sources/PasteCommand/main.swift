import ArgumentParser
import Common

let VERSION = "0.1.0"

@main
struct PasteCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "imgpaste",
        abstract: "Extract an image from the clipboard"
    )

    @Option(
        name: .shortAndLong,
        help: ArgumentHelp(
            "Output file path. Writes to standard output if omitted. " +
                "Automatically adds the correct file extension if omitted.",
            valueName: "file"
        )
    )
    var output: String?

    @Flag(name: .shortAndLong, help: ArgumentHelp("Show image metadata."))
    var info = false

    @Flag(name: .shortAndLong, help: ArgumentHelp("Print to standard output.", visibility: .hidden))
    var stdout = false

    @Flag(name: [.customShort("V"), .long], help: ArgumentHelp("Show the version."))
    var version = false

    func run() throws {
        if version {
            print(VERSION)
            return
        }

        let data = try Pasteboard.readImages()
        for (image, ext) in data {
            print(image, ext)
        }
    }
}
