import AppKit
import UniformTypeIdentifiers

public enum Pasteboard {
    public static func readImages() -> [(Data, String)] {
        var data: [(Data, String)] = []
        let pasteboard = NSPasteboard.general

        for item in pasteboard.pasteboardItems ?? [] {
            if let (image, ext) = readImage(from: item) {
                data.append((image, ext))
            }
        }

        return data
    }

    private static func readImage(from item: NSPasteboardItem) -> (Data, String)? {
        for type in item.types {
            if type == .fileURL {
                if let url = item.string(forType: .fileURL) {
                    return try? Filesystem.readImage(url: url)
                }

                return nil
            }

            if let utType = UTType(type.rawValue),
               utType.conforms(to: .image),
               let data = item.data(forType: type),
               let ext = utType.preferredFilenameExtension
            {
                return (data, ext)
            }
        }

        return nil
    }

    public static func writeImage(_ data: Data) throws {}

    public static func getMetadata(from data: Data) -> [CFString: Any]? {
        if
            let src = CGImageSourceCreateWithData(data as CFData, nil),
            let props = CGImageSourceCopyPropertiesAtIndex(src, 0, nil)
            as? [CFString: Any]
        {
            return props
        }

        return nil
    }
}
