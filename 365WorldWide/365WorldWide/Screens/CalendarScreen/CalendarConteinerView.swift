//
//  CalendarConteinerView.swift
//  SportUs
//
//  Created by MacBook on 09.06.2023.
//

import UIKit
import JTAppleCalendar

class CalendarConteinerView: UIView {

    var calendarView: JTACMonthView!
    let monthLabel = UILabel()
    let iconImageView = UIImageView()

let backButton: UIButton = {
    let button = UIButton()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
    button.setImage(UIImage(systemName: "chevron.left")?.withConfiguration(imageConfig), for: .normal)
    button.tintColor = .mainYellowColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentMode = .center
    return button
}()

let forwardButton: UIButton = {
    let button = UIButton()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold, scale: .large)
    button.setImage(UIImage(systemName: "chevron.right")?.withConfiguration(imageConfig), for: .normal)
    button.tintColor = .mainYellowColor
    button.translatesAutoresizingMaskIntoConstraints = false
    button.contentMode = .center
    return button
}()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setUpCalendarView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
func setUp() {
    self.backgroundColor = UIColor(red: 0.1059, green: 0.1294, blue: 0.1647, alpha: 1.0)
    self.layer.cornerRadius = 13
    self.clipsToBounds = true
    let stackView = UIStackView()
    let items: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    for item in items {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor(red: 0.2353, green: 0.2353, blue: 0.2627, alpha: 1.0).withAlphaComponent(0.3)
        label.text = item
        label.textAlignment = .center
        stackView.addArrangedSubview(label)
    }
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    addSubview(stackView)
    stackView.isHidden = true
    
    addSubview(monthLabel)
    monthLabel.font = .systemFont(ofSize: 20, weight: .semibold)
    monthLabel.textColor = .white
    monthLabel.textAlignment = .center
    
    addSubview(iconImageView)
    iconImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal)
    iconImageView.translatesAutoresizingMaskIntoConstraints = false
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let buttonsStack = UIStackView(arrangedSubviews: [backButton, forwardButton])
    buttonsStack.axis = .horizontal
    buttonsStack.distribution = .fillEqually
    buttonsStack.spacing = 10
    buttonsStack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(buttonsStack)
    
    NSLayoutConstraint.activate([
        stackView.heightAnchor.constraint(equalToConstant: 25),
        stackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 13),
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        
        monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
        monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        iconImageView.trailingAnchor.constraint(equalTo: monthLabel.trailingAnchor, constant: 12),
        iconImageView.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
        
        buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        buttonsStack.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
        buttonsStack.heightAnchor.constraint(equalToConstant: 30),
        buttonsStack.widthAnchor.constraint(equalToConstant: 60),
    ])
}
    
    func setUpCalendarView() {
        calendarView = JTACMonthView()
        addSubview(calendarView)
        calendarView.backgroundColor = UIColor(red: 0.1059, green: 0.1294, blue: 0.1647, alpha: 1.0)
        calendarView.scrollDirection = .horizontal
        calendarView.scrollingMode = .stopAtEachSection
        calendarView.showsHorizontalScrollIndicator = false
        calendarView.register(CalendarCollectionViewCell.self, forCellWithReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier)
     
        calendarView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            calendarView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 36),
            calendarView.heightAnchor.constraint(equalToConstant: 246),
        ])
    }
}
