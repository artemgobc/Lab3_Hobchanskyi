
import Foundation

// Клас, який зберігає інформацію про користувача.
class UserProfile {

    var name: String
    var email: String
    var age: Int?
    var wantsNotifications: Bool
    var studyDirection: String

    // Ініціалізатор для створення анкети.
    init(
        name: String,
        email: String,
        age: Int?,
        wantsNotifications: Bool,
        studyDirection: String
    ) {
        self.name = name
        self.email = email
        self.age = age
        self.wantsNotifications = wantsNotifications
        self.studyDirection = studyDirection
    }

    // Метод для виведення інформації в консоль.
    func printInfo() {

        print("===== АНКЕТА КОРИСТУВАЧА =====")

        print("Ім'я: \(name)")
        print("Email: \(email.isEmpty ? "не вказано" : email)")

        if let age = age {
            print("Вік: \(age)")
        } else {
            print("Вік: не вказано")
        }

        print("Отримувати сповіщення: \(wantsNotifications)")
        print("Напрям навчання: \(studyDirection)")

        print("==============================")
    }
}
