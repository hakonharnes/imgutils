import ArgumentParser
import Common

@main
struct PasteCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "imgpaste",
        abstract: "Extract an image from the clipboard"
    )

    @Option(name: .shortAndLong)
    var output: String?

    @Flag(name: .shortAndLong)
    var info = false

    func run() throws {
        print("PasteCommand stub. output: \(output ?? "none"), info: \(info)")
    }
}
