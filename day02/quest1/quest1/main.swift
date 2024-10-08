import Foundation

final class Company {
    let name: String
    let activity: String
    let description: String
    let contacts: String

    var vacancies: [Vacancy]
    var requiredSkills: [String]

    init(name: String, activity: String, description: String, vacancies: [Vacancy], requiredSkills: [String], contacts: String) {
        self.name = name
        self.activity = activity
        self.description = description
        self.vacancies = vacancies
        self.requiredSkills = requiredSkills
        self.contacts = contacts
    }

    func interview(candidate: Candidate) -> Bool {
        let matchingSkills = Set(candidate.skills).intersection(requiredSkills).count
        let skillMatchRatio = Double(matchingSkills) / Double(requiredSkills.count)
        return skillMatchRatio >= 0.5 ? Bool.random() : false
    }
}

final class Vacancy {
    let profession: String
    let level: String
    let salary: Double

    init(profession: String, level: String, salary: Double) {
        self.profession = profession
        self.level = level
        self.salary = salary
    }
}

final class Candidate {
    let name: String
    let profession: String
    let level: String
    let salary: Double
    let skills: [String]

    init(name: String, profession: String, level: String, salary: Double, skills: [String]) {
        self.name = name
        self.profession = profession
        self.level = level
        self.salary = salary
        self.skills = skills
    }
}

let companies = [
    Company(
        name: "SBER",
        activity: "Banking",
        description: "Russian majority state-owned banking and financial services company",
        vacancies: [
            Vacancy(profession: "Developer", level: "junior", salary: 100_000),
            Vacancy(profession: "QA", level: "junior", salary: 70_000),
            Vacancy(profession: "Project Manager", level: "middle", salary: 250_000)
        ],
        requiredSkills: ["Swift", "SwiftUI", "algorithms"], 
        contacts: "88005555550"
    ),

    Company(
        name: "Yandex",
        activity: "IT",
        description: "Russian multinational technology company",
        vacancies: [
            Vacancy(profession: "Developer", level: "junior", salary: 100_000),
            Vacancy(profession: "Developer", level: "middle", salary: 250_000),
            Vacancy(profession: "Analyst", level: "junior", salary: 70_000),
            Vacancy(profession: "Designer", level: "middle", salary: 220_000)
        ],
        requiredSkills: ["Swift", "C", "SwiftUI", "algorithms"], 
        contacts: "88002509639"
    ),

    Company(
        name: "Apple",
        activity: "IT",
        description: "American multinational technology company",
        vacancies: [
            Vacancy(profession: "Developer", level: "junior", salary: 190_000),
            Vacancy(profession: "QA", level: "junior", salary: 80_000)
        ],
        requiredSkills: ["Swift", "Objective-C", "C++", "C"],
        contacts: "18008543680"
    ),

    Company(
        name: "VK",
        activity: "IT",
        description: "Social network from Aeroport and Pavel Durov",
        vacancies: [
            Vacancy(profession: "Developer", level: "senior", salary: 300_000),
            Vacancy(profession: "Developer", level: "middle", salary: 100_000),
            Vacancy(profession: "Project Manager", level: "middle", salary: 150_000)
        ],
        requiredSkills: ["Swift", "SwiftUI", "Objective-C"],
        contacts: "office@vk.company"
    ),

    Company(
        name: "Avito",
        activity: "IT",
        description: "Russian classified advertisements website",
        vacancies: [
            Vacancy(profession: "Developer", level: "middle", salary: 210_000),
            Vacancy(profession: "Developer", level: "senior", salary: 340_000),
            Vacancy(profession: "QA", level: "junior", salary: 80_000)
        ],
        requiredSkills: ["Swift", "UIKit", "algorithms"],
        contacts: "https://support.avito.ru"
    )
]

let candidate = Candidate(
    name: "Sergey",
    profession: "Developer",
    level: "junior",
    salary: 60_000,
    skills: ["Swift", "algorithms", "C", "Docker", "CICD"]
)

func findSuitableVacancies(for candidate: Candidate) -> [(Company, Vacancy)] {
    return companies.flatMap { company in
        company.vacancies.filter { vacancy in
            vacancy.profession == candidate.profession &&
            vacancy.level == candidate.level &&
            vacancy.salary >= candidate.salary
        }.map { (company, $0) }
    }
}

func main() {
    let suitableVacancies = findSuitableVacancies(for: candidate)

    print("""
          Candidate:
          - Name: \(candidate.name)
          - Profession: \(candidate.profession)
          - Level: \(candidate.level)
          - Salary: \(candidate.salary)
          - Skills: \(candidate.skills.joined(separator: ", "))
          """)

    print("\nList of suitable vacancies:")
    for (index, (company, vacancy)) in suitableVacancies.enumerated() {
        print("""
        \(index + 1). \(vacancy.level) \(vacancy.profession) --- Salary: \(vacancy.salary)
          Company: \(company.name)
          Activity: \(company.activity)
          Required Skills: \(company.requiredSkills.joined(separator: ", "))
        ---------------------------------------
        """)
    }

    // Handling user input for selecting a vacancy
    while true {
        print("Enter a vacancy number:")
        if let input = readLine(), let vacancyNumber = Int(input), vacancyNumber > 0 && vacancyNumber <= suitableVacancies.count {
            let (selectedCompany, _) = suitableVacancies[vacancyNumber - 1]

            print("Processing Interview...\n")
            if selectedCompany.interview(candidate: candidate) {
                print("Success! The candidate passed the interview.")
            } else {
                print("Unfortunately, the candidate did not pass the interview.")
            }
            break
        } else {
            print("Invalid input, please try again.")
        }
    }
}

// Call the main function
main()
