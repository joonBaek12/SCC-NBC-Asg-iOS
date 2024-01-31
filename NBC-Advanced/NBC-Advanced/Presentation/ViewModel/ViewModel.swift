//
//  ViewModel.swift
//  NBC-Advanced
//
//  Created by Joon Baek on 2024/01/31.
//

import Foundation
import Combine

final class ViewModel {
    private (set) var model = VideoInfoModel()
    
    var cancellables = Set<AnyCancellable>()
}

extension ViewModel {
    func fetchData() async {
        guard
            let url = URL(
                string: "https://gist.githubusercontent.com/poudyalanil/ca84582cbeb4fc123a13290a586da925/raw/14a27bd0bcd0cd323b35ad79cf3b493dddf6216b/videos.json"
            )
        else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        // 데이터 추출
            .tryMap { $0.data }
            .decode(type: [VideoInfoResponse].self, decoder: JSONDecoder())
        // 데이터 스트림 값을 받아오기
            .receive(on: DispatchQueue.main)
        // 받아온 데이터 스트림값 처리
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] videoInfoList in
                    self?.model.videoInfoList = videoInfoList
                }
            )
            .store(in: &cancellables)
    }
}
