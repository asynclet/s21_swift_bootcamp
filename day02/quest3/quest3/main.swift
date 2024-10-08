import Foundation

struct Candidate {
    let fullName: String
    let profession: String
    let sex: String
    let birthDate: String
    let contacts: String
    let workExperiences: [WorkExperience]

    func totalWorkExperience() -> Double {
        return workExperiences.reduce(0) { $0 + $1.yearsOfExperience }
    }

    func seniorityLevel() -> String {
        let experience = totalWorkExperience()
        switch experience {
        case 0..<1:
            return "junior"
        case 1..<3:
            return "middle"
        default:
            return "senior"
        }
    }
}

struct WorkExperience {
    let workingPeriod: String
    let companyName: String
    let description: String

    var yearsOfExperience: Double {
        let components = workingPeriod.components(separatedBy: "-")
        guard components.count == 2, let startYear = Int(components[0].trimmingCharacters(in: .whitespaces)) else {
            return 0
        }

        let endYear: Int
        if components[1].trimmingCharacters(in: .whitespaces).lowercased() == "present" {
            endYear = Calendar.current.component(.year, from: Date())
        } else if let endYearValue = Int(components[1].trimmingCharacters(in: .whitespaces)) {
            endYear = endYearValue
        } else {
            return 0
        }

        return Double(endYear - startYear)
    }
}

struct Vacancy {
    let profession: String
    let level: String
    let salary: Double
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

func findSuitableVacancies(for candidate: Candidate, vacancies: [Vacancy]) -> [Vacancy] {
    let candidateLevel = candidate.seniorityLevel()

    return vacancies.filter { vacancy in
        vacancy.profession.lowercased() == candidate.profession.lowercased() && vacancy.level.lowercased() == candidateLevel
    }
}

// Sample list of vacancies (from Task 1)
let vacancies = [
    Vacancy(profession: "Developer", level: "junior", salary: 100_000),
    Vacancy(profession: "Developer", level: "middle", salary: 250_000),
    Vacancy(profession: "Developer", level: "senior", salary: 300_000),
    Vacancy(profession: "QA", level: "junior", salary: 70_000),
    Vacancy(profession: "Project Manager", level: "middle", salary: 150_000),
    Vacancy(profession: "Designer", level: "middle", salary: 220_000)
]

// Main logic
func analyzeResumes() {
    let resumePath = "/path/to/resume.txt"
    let tagsPath = "/path/to/tags.txt"
    let exportPath = "/path/to/export.txt"
    let analysisPath = "/path/to/analysis.txt"

    // Example candidate data (this would be parsed from the resume)
    let candidate = Candidate(
        fullName: "Sergey Petrov",
        profession: "Developer",
        sex: "Male",
        birthDate: "1990-01-01",
        contacts: "sergey@mail.com",
        workExperiences: [
            WorkExperience(workingPeriod: "2018-2020", companyName: "Yandex", description: "Junior Developer"),
            WorkExperience(workingPeriod: "2020-2023", companyName: "VK", description: "Middle Developer")
        ]
    )

    // 1. Calculate candidate's total work experience
    let totalExperience = candidate.totalWorkExperience()
    let candidateLevel = candidate.seniorityLevel()

    // 2. Find suitable vacancies based on profession and seniority level
    let suitableVacancies = findSuitableVacancies(for: candidate, vacancies: vacancies)

    // 3. Prepare the analysis file content
    var analysisContent = """
    Candidate Information:
    - Full Name: \(candidate.fullName)
    - Profession: \(candidate.profession)
    - Level: \(candidateLevel)
    - Total Work Experience: \(totalExperience) years
    - Contacts: \(candidate.contacts)

    Suitable Vacancies:
    """

    for (index, vacancy) in suitableVacancies.enumerated() {
        analysisContent += "\n\(index + 1). \(vacancy.profession) - \(vacancy.level) - \(vacancy.salary) salary"
    }

    // 4. Write the analysis content to analysis.txt
    writeFile(atPath: analysisPath, content: analysisContent)

    print("Resume analysis complete. Check analysis.txt.")
}

// Run the analysis
analyzeResumes()
