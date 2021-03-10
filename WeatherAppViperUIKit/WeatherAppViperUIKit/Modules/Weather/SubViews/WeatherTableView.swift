import UIKit

class WeatherTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private let cellReuseIdentifier = "weather_table_cell"
    private let data = [1, 2, 3]

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        initTable()
    }

    func update() {

        reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: WeatherTableViewCell = dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? WeatherTableViewCell else {
            return UITableViewCell()
        }

        cell.update(title: "Cell \(indexPath.row)", value: "Cell \(indexPath.row)")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    private func initTable() {
        register(WeatherTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        delegate = self
        dataSource = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 80
    }
}
