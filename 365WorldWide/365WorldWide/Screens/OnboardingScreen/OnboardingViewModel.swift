//
//  OnboardingViewModel.swift
//  BetCounter
//
//  Created by MacBook on 27.04.2023.
//

import Foundation

struct OnboardingModel {
    let title: String
    let subTitle: String
    let bgImageName: String
    let smallBGImageName: String
}

final class OnboardingViewModel {
    
    var onboardingData: [OnboardingModel] = []
    
    func fillModel() {
        onboardingData.append(OnboardingModel(title: "World Map of Events!",
                                              subTitle: "Follow all the events that are happening on the globe.",
                                              bgImageName: "", smallBGImageName: "onBoard1small"))
        onboardingData.append(OnboardingModel(title: "Schedule and  Results",
                                              subTitle: "Stay up to date with the latest results of your favorite matches. ",
                                              bgImageName: "onBoard2", smallBGImageName: "onBoard2small"))
        onboardingData.append(OnboardingModel(title: "All Game Statistic",
                                              subTitle: "Use the most convenient tool for analyzing sports events around the world.",
                                              bgImageName: "onBoard3", smallBGImageName: "onBoard2small"))
    }
}
