//
//  ViewModel.swift
//  NBC-Advanced
//
//  Created by Joon Baek on 2024/01/31.
//

import Foundation

final class ViewModel {
    private (set) var model = VideoInfoModel()
}

extension ViewModel {
    func fetchData() async {
        guard
            let url = URL(
                string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
            )
        else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let videoInfoList = try JSONDecoder().decode([VideoInfoResponse].self, from: data)
            model.videoInfoList = videoInfoList
        } catch {
            print("Error: \(error)")
        }
    }
}
