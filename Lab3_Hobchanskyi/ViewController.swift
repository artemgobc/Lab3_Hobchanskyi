
import UIKit

class ViewController: UIViewController,
                      UIPickerViewDataSource,
                      UIPickerViewDelegate {

    // MARK: - Зв'язки з елементами Storyboard

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var directionPickerView: UIPickerView!
    @IBOutlet weak var statusLabel: UILabel!

    // Масив напрямів навчання.
    private let directions = [
        "iOS-розробка",
        "Веброзробка",
        "Розробка ігор",
        "Кібербезпека"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Підключаємо Picker View до джерела даних.
        directionPickerView.dataSource = self
        directionPickerView.delegate = self

        // Вибираємо перший напрям за замовчуванням.
        directionPickerView.selectRow(
            0,
            inComponent: 0,
            animated: false
        )

        // Завантажуємо зображення профілю.
        profileImageView.image =
            UIImage(named: "avatar")
            ?? UIImage(systemName: "person.crop.circle.fill")

        profileImageView.contentMode = .scaleAspectFit
        profileImageView.tintColor = .systemBlue

        // Налаштовуємо поля введення.
        nameTextField.placeholder = "Введіть ім'я"

        emailTextField.placeholder = "Введіть електронну пошту"
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none

        ageTextField.placeholder = "Введіть вік"
        ageTextField.keyboardType = .numberPad

        // Початковий текст повідомлення.
        statusLabel.numberOfLines = 0
        statusLabel.text = "Заповни анкету та натисни «Зберегти»."
    }

    // MARK: - Налаштування Picker View

    // Кількість колонок.
    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {
        return 1
    }

    // Кількість рядків.
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return directions.count
    }

    // Назва кожного рядка.
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return directions[row]
    }

    // MARK: - Збереження анкети

    @IBAction func saveProfile(_ sender: UIButton) {

        // Отримуємо ім'я та прибираємо зайві пробіли.
        let name = (nameTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // Перевіряємо, чи введено ім'я.
        guard !name.isEmpty else {
            statusLabel.text = "Будь ласка, введи ім'я."
            print("Помилка: ім'я не вказано.")
            return
        }

        // Отримуємо електронну пошту.
        let email = (emailTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // Отримуємо вік.
        let ageText = (ageTextField.text ?? "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        var age: Int? = nil

        // Перевіряємо вік, якщо поле не порожнє.
        if !ageText.isEmpty {

            guard let enteredAge = Int(ageText),
                  (1...120).contains(enteredAge) else {

                statusLabel.text =
                    "Вік має бути числом від 1 до 120."

                print("Помилка: некоректний вік.")
                return
            }

            age = enteredAge
        }

        // Отримуємо вибраний напрям.
        let selectedRow =
            directionPickerView.selectedRow(inComponent: 0)

        let selectedDirection = directions[selectedRow]

        // Створюємо об'єкт класу UserProfile.
        let profile = UserProfile(
            name: name,
            email: email,
            age: age,
            wantsNotifications: notificationsSwitch.isOn,
            studyDirection: selectedDirection
        )

        // Виводимо дані в консоль.
        profile.printInfo()

        // Повідомляємо користувача про успіх.
        statusLabel.text =
            "Анкету збережено! Перевір консоль Xcode."

        // Закриваємо клавіатуру.
        view.endEditing(true)
    }
}
