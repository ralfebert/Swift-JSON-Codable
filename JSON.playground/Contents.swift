import Foundation

// MARK: - Declare JSON-Types conforming to the Codable

struct Person: Codable {
    let name: String
    let age: Int
    let phone: [Phone]?
    let address: Address?
}

struct Address: Codable {
    let street, zip, city: String
}

struct Phone: Codable {
    let type, number: String
}

// Parsing JSON from a project file

if let jsonURL = Bundle.main.url(forResource: "person", withExtension: "json") {
    let jsonData = try Data(contentsOf: jsonURL)
    let jsonDecoder = JSONDecoder()
    let person = try jsonDecoder.decode(Person.self, from: jsonData)
    print(person.name)
}

print("---")

// Generating JSON

let persons = [
    Person(
        name: "Bob",
        age: 35,
        phone: [
            Phone(type: "mobile", number: "123"),
        ],
        address: Address(street: "Some street", zip: "01234", city: "Fantasity")
    ),
]
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted
let jsonResultData = try jsonEncoder.encode(persons)
if let jsonResultString = String(data: jsonResultData, encoding: .utf8) {
    print(jsonResultString)
}
