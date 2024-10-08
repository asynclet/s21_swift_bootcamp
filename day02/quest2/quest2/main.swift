import Foundation

// Define a struct to hold candidate information
struct Candidate {
    let fullName: String
    let profession: String
    let sex: String
    let birthDate: String
    let contacts: String
}

struct Education {
    let type: String
    let yearsOfStudy: String
    let description: String
}

struct WorkExperience {
    let workingPeriod: String
    let companyName: String
    let description: String
}

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

func findMatchingTags(in words: [String: Int], tags: [String]) -> [String] {
    return words.keys.filter { tags.contains($0) }
}

// Main logic
func analyzeResumes() {
    let resumePath = "/path/Swift_Bootcamp.Day02-1/data-samples/resume.txt"
    let tagsPath = "/path/Swift_Bootcamp.Day02-1/data-samples/tags.txt"
    let exportPath = "/path/Swift_Bootcamp.Day02-1/data-samples/export.txt"
    let analysisPath = "/path/Swift_Bootcamp.Day02-1/data-samples/analysis.txt"

    // 1. Read resume and tags
    guard let resumeContent = readFile(atPath: resumePath),
          let tagsContent = readFile(atPath: tagsPath) else {
        print("Error reading input files.")
        return
    }

    // 2. Parse tags
    let tags = tagsContent.lowercased().components(separatedBy: .newlines).filter { !$0.isEmpty }

    // 3. Count word occurrences in the resume
    let wordCounts = countWords(in: resumeContent)

    // 4. Find words that match the tags
    let matchingTags = findMatchingTags(in: wordCounts, tags: tags)

    // 5. Prepare the analysis file content
    var analysisContent = "Word Counts:\n"
    let sortedWordCounts = wordCounts.sorted { $0.value > $1.value }

    for (word, count) in sortedWordCounts {
        analysisContent += "\(word) - \(count)\n"
    }

    analysisContent += "\nMatching Tags:\n"
    for tag in matchingTags {
        analysisContent += "\(tag)\n"
    }

    // 6. Export the resume content to export.txt
    writeFile(atPath: exportPath, content: resumeContent)

    // 7. Write the analysis content to analysis.txt
    writeFile(atPath: analysisPath, content: analysisContent)

    print("Resume analysis complete. Check export.txt and analysis.txt.")
}

// Run the analysis
analyzeResumes()
