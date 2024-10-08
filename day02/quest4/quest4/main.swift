import Foundation

func readFile(atPath path: String) -> String? {
    do {
        return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
        print("Error reading file at \(path): \(error)")
        return nil
    }
}

func writeFile(atPath path: String, content: String) {
    do {
        try content.write(toFile: path, atomically: true, encoding: .utf8)
    } catch {
        print("Error writing to file at \(path): \(error)")
    }
}

func countWords(in text: String) -> [String: Int] {
    let words = text.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted)
    var wordCount: [String: Int] = [:]

    for word in words where !word.isEmpty {
        wordCount[word, default: 0] += 1
    }

    return wordCount
}

func findPossibleTags(in words: [String: Int], tags: [String], nonTagWords: [String]) -> [String] {
    return words.keys.filter { !tags.contains($0) && !nonTagWords.contains($0) }
}

// Main logic
func analyzeResumes() {
    let resumePath = "/path/to/resume.txt"
    let tagsPath = "/path/to/tags.txt"
    let notATagPath = "/path/to/notATag.txt"
    let analysisPath = "/path/to/analysis.txt"

    // 1. Read resume, tags, and notATag files
    guard let resumeContent = readFile(atPath: resumePath),
          let tagsContent = readFile(atPath: tagsPath),
          let notATagContent = readFile(atPath: notATagPath) else {
        print("Error reading input files.")
        return
    }

    // 2. Parse tags and notATag words
    let tags = tagsContent.lowercased().components(separatedBy: .newlines).filter { !$0.isEmpty }
    let nonTagWords = notATagContent.lowercased().components(separatedBy: .newlines).filter { !$0.isEmpty }

    // 3. Count word occurrences in the resume
    let wordCounts = countWords(in: resumeContent)

    // 4. Find possible tags (words not found in tags or notATag)
    let possibleTags = findPossibleTags(in: wordCounts, tags: tags, nonTagWords: nonTagWords)

    // 5. Prepare the analysis file content
    var analysisContent = """
    Possible Tags:
    """

    for tag in possibleTags {
        analysisContent += "\n\(tag)"
    }

    // 6. Write the analysis content to analysis.txt
    writeFile(atPath: analysisPath, content: analysisContent)

    print("Analysis complete. Check analysis.txt for possible tags.")
}

// Run the analysis
analyzeResumes()
