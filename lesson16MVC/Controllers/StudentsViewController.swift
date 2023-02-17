//
//  ViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

final class StudentsViewController: UIViewController {

    @IBOutlet private weak var studentTableView: UITableView!

    private var students: [Student] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        studentTableView.register(
            UINib.init(nibName: StudentTableViewCell.reuseIdentifier, bundle: nil),
            forCellReuseIdentifier: StudentTableViewCell.reuseIdentifier
        )
        studentTableView.tableFooterView = UIView()//робить під табличкою білий футер(додаючи вью), якщо без нього до будемо бачити під таблицею порожні целі
        title = "Students"
        updateStudents()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StudentDetailsViewController, //as? -  це каст. ми кастимо до чогось щось. Ми так з комірками робили. А сігвей каститься так з певним вью контролером, щоб переходити на нього. Якщо не прописати оце as? StudentDetailsViewController, то нижче ми не зможемо викликати метод destination.setStudent(функція яка є в вью контроллері до якого ми закастилися)

           let indexPath = sender as? IndexPath { //sender це підготовка сігвею
            destination.setStudent(student: students[indexPath.row])//передаємо індех на який ми нажали - тобто комірку - і він буде відкривати свої дані в іншому вью контроллері до якого ми закастилися - StudentDetailsViewController в нашому випадку
            //нижче и екстеншені numberOfRowsInSection викликається метод performSegue - виконання сігвею
        }
    }

    // MARK: - Private

    private func updateStudents() {
        students = JsonService.shared.parseStudents()?.students ?? [] //парсимо студентів, присвоюємо їх властивості ст'юдентс  - заповнюємо масив студентів
        studentTableView.reloadData() //і оновлюємо дані таблички - відображення на ній нових даних. Тригерить делегат, який перерахує кількість комірок і сетап  таблички
    }
}

extension StudentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        students.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.reuseIdentifier,
                                                 for: indexPath)
        if let cell = cell as? StudentTableViewCell {
            cell.render(student: students[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "StudentDetails", sender: indexPath)//performSegue має 2 параметри withIdentifier - назва(як у комірок), і sender - хто відправляє дані (в нас це indexPath на який ми натискаємо)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
