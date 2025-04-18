import ArgumentParser
import Common

@main
struct CopyCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "imgcopy",
        abstract: "Copy an image to the clipboard"
    )

    @Option(name: .shortAndLong)
    var input: String?

    func run() throws {
        print("CopyCommand stub. input: \(input ?? "none")")
    }
}
