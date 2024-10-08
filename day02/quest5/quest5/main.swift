import Foundation

func readFile(atPath path: String) -> String? {
    do {
        return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
        print("Error reading file at \(path): \(error)")
        return nil
    }
}

func compareTextFiles(file1Path: String, file2Path: String) {
    guard let file1Content = readFile(atPath: file1Path),
          let file2Content = readFile(atPath: file2Path) else {
        print("Error reading one or both files.")
        return
    }

    if file1Content == file2Content {
        print("Text comparator: resumes are identical")
    } else {
        print("Text comparator: resumes are different")
    }
}

// Main logic
func main() {
    let resumePath = "/path/to/resume.txt" // Insert your path
    let exportPath = "/path/to/export.txt" // Insert your path

    compareTextFiles(file1Path: resumePath, file2Path: exportPath)
}

main()
