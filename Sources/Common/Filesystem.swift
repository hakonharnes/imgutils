import AppKit
import UniformTypeIdentifiers

public enum Filesystem {
    public static func readImage(url: String) throws -> (Data, String) {
        guard let url = URL(string: url) else {
            throw NSError(domain: "Invalid URL", code: 0)
        }

        if !FileManager.default.fileExists(atPath: url.path) {
            throw NSError(domain: "File does not exist", code: 0)
        }

        guard let ext = getPreferredExtension(for: url),
              let utType = UTType(filenameExtension: ext),
              utType.conforms(to: .image)
        else {
            throw NSError(domain: "File is not an image", code: 0)
        }

        return try (Data(contentsOf: url), ext)
    }

    public static func writeImage(data: Data, ext: String, to path: String) throws {
        var fileURL = URL(fileURLWithPath: path)
        if fileURL.pathExtension.isEmpty {
            fileURL = fileURL.appendingPathExtension(ext)
        }

        // TODO: Better error handling
        try data.write(to: fileURL, options: .atomic)
    }

    private static func getPreferredExtension(for url: URL) -> String? {
        if let type = try? url.resourceValues(forKeys: [.contentTypeKey]).contentType,
           let ext = type.preferredFilenameExtension
        {
            return ext
        }

        let pathExtension = url.pathExtension
        return pathExtension.isEmpty ? nil : pathExtension
    }
}
