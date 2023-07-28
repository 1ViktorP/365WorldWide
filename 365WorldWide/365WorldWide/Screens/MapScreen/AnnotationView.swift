//
//  AnnotationView.swift
//  TheBestSports
//
//  Created by MacBook on 28.02.2023.
//

import Foundation
import MapKit

class ObservationAnnotationView: MKAnnotationView {
    
    static let identifier = String(describing: ObservationAnnotationView.self)
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
