//
//  VideoInfoResponse.swift
//  NBC-Advanced
//
//  Created by Joon Baek on 2024/01/31.
//

import Foundation

struct VideoInfoResponse: Decodable {
  let id: String
  let title: String
  let thumbnailUrl: URL
  let videoUrl: URL
}
