//
//  MapViewController.swift
//  365WorldWide
//
//  Created by MacBook on 27.07.2023.
//

import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController {

    private var mapView = MKMapView()
    private var mapViewModel = MapViewModel()
    private let fixtureView = FixtureView()
    private var isSaved = false
    private var fixture: FixtureCellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mapView
        setUpMap()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapViewModel.fetchTodaysFixtures()
        setUp()
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
        fixtureView.isHidden = true
    }
    
    private func setUp() {
        mapViewModel.downloadedData = { [weak self] isPresentData in
            guard let self = self else { return }
            if isPresentData {
                self.mapViewModel.mapDataViewModel.forEach { data in
                                guard let coordinate = data.coordinates else { return }
                               self.addAnnotations(coordinate: coordinate)
                            }
                       }
        }
    }
    
    private func setUpView() {
        view.addSubview(fixtureView)
        fixtureView.translatesAutoresizingMaskIntoConstraints = false
        fixtureView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        fixtureView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -104).isActive = true
        fixtureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        fixtureView.heightAnchor.constraint(equalToConstant: 109).isActive = true
        fixtureView.isHidden = true
        fixtureView.clipsToBounds = true
    }
    
   private func addAnnotations(coordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func setUpMap() {
        mapView.delegate = self
        mapView.register(ObservationAnnotationView.self, forAnnotationViewWithReuseIdentifier: ObservationAnnotationView.identifier)
        let initialLocation = CLLocationCoordinate2D(latitude: 35.4770945, longitude: -6.1554201)
        let mapCamera = MKMapCamera()
        mapCamera.centerCoordinate = initialLocation
        mapCamera.pitch = 45
        mapCamera.altitude = 50000000
        mapCamera.heading = 45
        
        // set the camera property
        mapView.camera = mapCamera
    }
    
    func configure(with viewModel: FixtureCellViewModel) {
        fixtureView.isHidden = false
        fixtureView.homeTeamView.teamNameLabel.text = viewModel.homeTeamName
        fixtureView.homeTeamView.teamImageView.kf.setImage(with: viewModel.homeTeamIcon)
        fixtureView.awayTeamView.teamNameLabel.text = viewModel.awayTeamName
        fixtureView.awayTeamView.teamImageView.kf.setImage(with: viewModel.awayTeamIcon)
        fixtureView.statusLabel.text = viewModel.status
        var city = viewModel.city
        if let dotRange = city.range(of: ",") {
            city.removeSubrange(dotRange.lowerBound..<city.endIndex)
        }
        
        fixtureView.placeLabel.text = city + "," + viewModel.country
        
        if viewModel.status == "1H" || viewModel.status == "HT" || viewModel.status == "2H" ||  viewModel.status == "ET" ||
            viewModel.status == "BT" ||  viewModel.status == "P" {
            fixtureView.dateLabel.isHidden = true
            fixtureView.minuteLabel.isHidden = false
            fixtureView.minuteLabel.text = viewModel.minute + "'"
            fixtureView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
        } else if viewModel.status == "FT" {
            fixtureView.timeScoreLabel.text = viewModel.homeTeamScore + " - " + viewModel.awayTeamScore
            fixtureView.minuteLabel.isHidden = true
            fixtureView.dateLabel.isHidden = false
            fixtureView.dateLabel.text = Date.formatDateForCell(date: viewModel.date)
        } else {
            fixtureView.dateLabel.isHidden = false
            fixtureView.timeScoreLabel.text =  Date.formatHours(date: viewModel.date)
            fixtureView.minuteLabel.isHidden = true
        }
        isSaved = retrieveAndCheckFavorites(fixtureID: viewModel.id)
        if isSaved {
            fixtureView.saveButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            fixtureView.saveButton.setImage(UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        }
        fixtureView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    @objc func didTapSaveButton() {
        if !isSaved {
            isSaved = true
            guard let fixture = fixture else { return }
            addToFavorites(fixture: fixture)
        } else {
            isSaved = false
            guard let fixture = fixture else { return }
            deleteFavoriteItem(fixture: fixture)
        }
    }
    
    func retrieveAndCheckFavorites(fixtureID: String) -> Bool {
        let favoriteFixture = SaveManager.shared.getDataFromFavorite() as [FixtureCellViewModel]
        if favoriteFixture.contains(where: { $0.id == fixtureID }) {
            return true
        } else {
          return false
        }
    }

    func addToFavorites(fixture: FixtureCellViewModel) {
        print("add to favorite")
        fixtureView.saveButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        SaveManager.shared.setDataToFavorites(data: fixture)
    }

    func deleteFavoriteItem(fixture: FixtureCellViewModel) {
        fixtureView.saveButton.setImage(UIImage(systemName: "star")?.withTintColor(.mainYellowColor, renderingMode: .alwaysOriginal), for: .normal)
        print("remove from fav")
        SaveManager.shared.removeDataFromFavorites(id: fixture.id)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
               let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ObservationAnnotationView.identifier , for: annotation) as! ObservationAnnotationView
        annotationView.image = UIImage(named: "mapIcon")
               annotationView.canShowCallout = true
        
               return annotationView
           }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        UIDevice.vibrate()
        guard let coordinates = view.annotation?.coordinate else { return }
        guard let data = mapViewModel.mapDataViewModel.first(where: {$0.coordinates?.latitude == coordinates.latitude}) else { return }
        guard let fixture = mapViewModel.fixtureViewModel.first(where: {$0.id == data.fixtureId}) else { return }
        configure(with: fixture)
        self.fixture = fixture
        //guard let navigationController = navigationController else { return }
//        let coordinator = MainCoordinator(navigationController: navigationController)
//        coordinator.openDetailVC(fixture: fixture)
    }
       }

