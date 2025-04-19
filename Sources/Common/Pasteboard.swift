import AppKit
import UniformTypeIdentifiers

public enum Pasteboard {
    public static func readImages() throws -> [(Data, String)] {
        var data: [(Data, String)] = []
        let pasteboard = NSPasteboard.general

        for item in pasteboard.pasteboardItems ?? [] {
            if let imageData = readImage(from: item) {
                data.append(imageData)
            }
        }

        return data
    }

    private static func readImage(from item: NSPasteboardItem) -> (Data, String)? {
        for type in item.types {
            if type == .fileURL {
                if let url = item.string(forType: .fileURL),
                   let (data, ext) = try? Filesystem.readImage(url: url)
                {
                    return (data, ext)
                }

                return nil
            }

            if let utType = UTType(type.rawValue), utType.conforms(to: .image) {}
        }

        return nil
    }

    public static func writeImage(_ data: Data) throws {}
}
