import UIKit

class WeatherTableViewCell: UITableViewCell {
    private let titleLabel: UILabel = UILabel()
    private let valueLabel: UILabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        initView()
        placeView()
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        valueLabel.text = ""

        super.prepareForReuse()
    }

    func update(title: String, value: String) {
        titleLabel.text = title.uppercased()
        valueLabel.text = value
    }

    private func initView() {
        titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .light)
        valueLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .light)
    }

    private func placeView() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
        ])
    }
}
