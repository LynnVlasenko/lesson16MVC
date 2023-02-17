//
//  LessonTableViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 28.06.2021.
//

import UIKit

final class LessonTableViewController: UITableViewController {

    private var lessons: [Lesson] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Lessons"
        lessons = JsonService.shared.parseLessons()?.lessons ?? []
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lessons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonsTableViewCell", for: indexPath)
        cell.textLabel?.text = lessons[indexPath.row].name
        cell.detailTextLabel?.text = lessons[indexPath.row].hours
        return cell
    }
}
