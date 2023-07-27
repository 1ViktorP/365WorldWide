//
//  CalendarViewController.swift
//  SportUs
//
//  Created by MacBook on 08.06.2023.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {
    
    private let calendarConteinerView = CalendarConteinerView()
    private var dismissHandler: ((Date) -> Void)?
    private var anchorDate: Date!
    private var indexPath = IndexPath(row: 0, section: 0)
    private var isFirstTime = true
    
    init(selectedDate: Date, dismissHandler: ((Date) -> Void)? = nil) {
        self.dismissHandler = dismissHandler
        self.anchorDate = selectedDate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCalendarView()
    }

    
    private func setUpCalendarView() {
        let gesture = UITapGestureRecognizer()
        gesture.delegate = self
        gesture.addTarget(self, action: #selector(didTapGestureView))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor(red: 0.1137, green: 0.1137, blue: 0.1137, alpha: 0.2)
        view.addSubview(calendarConteinerView)
        calendarConteinerView.backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        calendarConteinerView.forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        calendarConteinerView.calendarView.calendarDataSource = self
        calendarConteinerView.calendarView.calendarDelegate = self
        calendarConteinerView.calendarView.reloadData(withAnchor: anchorDate)
        calendarConteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarConteinerView.widthAnchor.constraint(equalToConstant: 357),
            calendarConteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarConteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 36),
            calendarConteinerView.heightAnchor.constraint(equalToConstant: 326),
        ])
    }
  
    @objc func didTapGestureView() {
        UIDevice.vibrate()
        dismissHandler?(anchorDate)
        self.dismiss(animated: true)
    }
    
    @objc func didTapBackButton() {
        UIDevice.vibrate()
        calendarConteinerView.calendarView.scrollToSegment(.previous)
        calendarConteinerView.calendarView.reloadData()

    }
    
    @objc func didTapForwardButton() {
        UIDevice.vibrate()
        calendarConteinerView.calendarView.scrollToSegment(.next)
        calendarConteinerView.calendarView.reloadData()
    }
}

extension CalendarViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, willDisplay cell: JTAppleCalendar.JTACDayCell, forItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) {
        let cell = cell as! CalendarCollectionViewCell
        calendarConteinerView.monthLabel.text = Date.formatMonth(date: date)
//        if Date.formatForURL(date: date) == Date.formatForURL(date: anchorDate) {
//            cell.selectedCell()
//            self.indexPath = indexPath
//        }
        cell.dateLabel.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
              cell.isHidden = false
           } else {
               cell.isHidden = true
           }
    }
    
    func calendar(_ calendar: JTAppleCalendar.JTACMonthView, cellForItemAt date: Date, cellState: JTAppleCalendar.CellState, indexPath: IndexPath) -> JTAppleCalendar.JTACDayCell {
        let cell = calendar.dequeueReusableCell(withReuseIdentifier: CalendarCollectionViewCell.reuseIdentifier, for: indexPath) as! CalendarCollectionViewCell
        calendarConteinerView.monthLabel.text = Date.formatMonth(date: date)
        if Date.formatForURL(date: date) == Date.formatForURL(date: anchorDate) {
            if isFirstTime {
                cell.selectedCell()
                self.indexPath = indexPath
                isFirstTime = false
            }
        }
        cell.dateLabel.text = cellState.text
        if cellState.dateBelongsTo == .thisMonth {
              cell.isHidden = false
           } else {
               cell.isHidden = true
           }
        return cell
    }

    func configureCalendar(_ calendar: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let startDate = Date.getFirstAndLastDayOfTheYear().0
        let endDate = Date.getFirstAndLastDayOfTheYear().1

            return ConfigurationParameters(startDate: startDate,
                                           endDate: endDate,
                                           numberOfRows: 7,
                                           generateInDates: .forAllMonths,
                                           generateOutDates: .off,
                                           firstDayOfWeek: .sunday,
                                           hasStrictBoundaries: true)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        UIDevice.vibrate()
        calendar.reloadData()
        //var _date = date.addingTimeInterval(86400)
        anchorDate = date//_date
        dismissHandler?(anchorDate)
        self.dismiss(animated: true)
    }
}

extension CalendarViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}

