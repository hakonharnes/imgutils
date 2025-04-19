import ArgumentParser
import Common
import Foundation

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

        let data = Pasteboard.readImages()
        if data.isEmpty {
            print("Error: No image data found in the clipboard.")
            return
        }

        if isTTY() && info == false && output == nil && stdout == false {
            print("Error: Refusing to write binary data to a terminal. Use --stdout to force.")
            return
        }

        for (image, ext) in data {
            if info {
                if let metadata = Pasteboard.getMetadata(from: image) {
                    print("Format: \(ext)")
                    print(metadata)
                    print()
                }

                continue
            }

            if let output {
                try Filesystem.writeImage(data: image, ext: ext, to: output)
            } else {
                FileHandle.standardOutput.write(image)
            }
        }
    }
}
