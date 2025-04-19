import Darwin

public func isTTY() -> Bool {
    isatty(STDOUT_FILENO) != 0
}
