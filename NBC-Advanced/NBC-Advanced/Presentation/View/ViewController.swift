//
//  ViewController.swift
//  NBC-Advanced
//
//  Created by Joon Baek on 2024/01/26.
//

import UIKit
import AVKit

final class ViewController: UITableViewController {
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        register()
        handleFetchData()
        bindViewModel()
    }
}

// MARK: - Extensions

extension ViewController {
    private func presentPlayerViewController(videoURL: URL) {
        let playerController = AVPlayerViewController()
        
        let player = AVPlayer(url: videoURL as URL)
        playerController.player = player
        
        self.present(playerController, animated: true) {
            player.play() // 비디오 재생 메서드
        }
    }
}

// MARK: - Extensions

extension ViewController {
    private func register() {
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
    }
    
    private func handleFetchData() {
        Task {
            await viewModel.fetchData()
        }
    }
    
    private func bindViewModel() {
        // $ - Publisher
        viewModel.model.$videoInfoList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
    }
}

// MARK: - TableView

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.videoInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = viewModel.model.videoInfoList[indexPath.row]
        presentPlayerViewController(videoURL: movie.videoUrl)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: VideoCell.identifier, for: indexPath) as? VideoCell
        else {
            return UITableViewCell()
        }
        
        let movie = viewModel.model.videoInfoList[indexPath.row]
        
        cell.setThumbnail(imageURL: movie.thumbnailUrl)
        cell.setTitle(title: movie.title)
        
        return cell
    }
}
