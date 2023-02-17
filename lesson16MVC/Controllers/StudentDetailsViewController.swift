//
//  StudentDetailsViewController.swift
//  testtt
//
//  Created by Volodymyr Rykhva on 07.07.2021.
//

import UIKit

final class StudentDetailsViewController: UIViewController {

    @IBOutlet private weak var studentImageView: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    
    private var student: Student?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        renderStudent()
    }


    // MARK: - Private

    func renderStudent() {
        guard let student = student else { return }

        title = student.name
        studentImageView.load(url: student.logo)
        emailLabel.text = student.email
    }

    func setStudent(student: Student?) {
        self.student = student
    }
}
