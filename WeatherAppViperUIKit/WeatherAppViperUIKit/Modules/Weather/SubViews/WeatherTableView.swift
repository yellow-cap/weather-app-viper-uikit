import UIKit

class WeatherTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    private let cellReuseIdentifier = "weather_table_cell"
    private var data = [(String, String)]()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        initTable()
    }

    func update(data: [(String, String)]) {
        self.data = data
        reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: WeatherTableViewCell = dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? WeatherTableViewCell else {
            return UITableViewCell()
        }

        cell.update(title: data[indexPath.row].0, value: data[indexPath.row].1)

        return cell
    }

    private func initTable() {
        register(WeatherTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        delegate = self
        dataSource = self
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 60
        allowsSelection = false
    }
}
