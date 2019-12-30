/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

class DemoListViewController: UIViewController {
    private struct Constants {
        static let cellIdentifier = "demoCellId"
        static let cellHeight = 44.0
    }

    var demoList: [DemoFactoryProtocol] = []

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

extension DemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)

        cell.textLabel?.text = demoList[indexPath.row].title

        return cell
    }
}

extension DemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        do {
            let wallet = try demoList[indexPath.row].setupDemo { [weak self] (nextViewController) in
                self?.dismiss(animated: true, completion: nil)

                if let viewController = nextViewController {
                    viewController.modalPresentationStyle = .fullScreen
                    self?.present(viewController, animated: true, completion: nil)
                }
            }

            wallet.modalPresentationStyle = .fullScreen

            present(wallet, animated: true, completion: nil)
        } catch {
            print("Can't create demo \(error)")
        }
    }
}
