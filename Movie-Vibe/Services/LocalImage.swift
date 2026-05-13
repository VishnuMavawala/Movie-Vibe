//
//  LocalImage.swift
//  Movie-Vibe
//
//  Created by Vishnu Mavawala on 31/03/26.
//

import SwiftUI
import Combine

class ImageCache {
    static let shared = ImageCache()
    
    private var cache = NSCache<NSString, UIImage>()
    
    private func getCacheDirectory() -> URL? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let folderURL = cachesDirectory.appendingPathComponent("CatchImages")
        
        if !FileManager.default.fileExists(atPath: folderURL.path) {
            do {
                // Create folder
                try FileManager.default.createDirectory(
                    at: folderURL,
                    withIntermediateDirectories: true,
                    attributes: nil
                )
                print("Created folder at: \(folderURL.path)")
            } catch {
                print("Failed to create folder: \(error)")
                return nil
            }
        }
        
        return folderURL
    }
    
    func get(forKey key: String) -> UIImage? {
        if let image = cache.object(forKey: key as NSString) {
            return image
        }
        if let diskImage = loadImageFromDisk(forKey: key) {
            cache.setObject(diskImage, forKey: key as NSString)
            return diskImage
        }
        return nil
    }
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        saveImageToDisk(image, forKey: key)
    }
    
    private func saveImageToDisk(_ image: UIImage, forKey key: String) {
        guard let data = image.jpegData(compressionQuality: 0.7),
              let directory = getCacheDirectory() else {
            return
        }
        let fileURL = directory.appendingPathComponent(key)
        try? data.write(to: fileURL)
    }
    
    private func loadImageFromDisk(forKey key: String) -> UIImage? {
        guard let directory = getCacheDirectory() else {
            return nil
        }
        let fileURL = directory.appendingPathComponent(key)
        return UIImage(contentsOfFile: fileURL.path)
    }
}

class LocalImage: ObservableObject {
    
    @Published var image: UIImage? = nil
    
    private func downloadImage(url: URL) async throws -> UIImage? {
        try await withCheckedThrowingContinuation({ continuation in
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data,
                      let uiImage = UIImage(data: data) else {
                    continuation.resume(throwing: NetworkError.imageError)
                    return
                }
                ImageCache.shared.set(uiImage, forKey: url.lastPathComponent)
                continuation.resume(returning: uiImage)
            }.resume()
        })
    }
    
    func getImage(url: URL?) async {
        guard let url = url else {
            return
        }
        
        if let img = ImageCache.shared.get(forKey: url.lastPathComponent) {
            image = img
            return
        }
        print("Loading Image \(url)")
        image = try? await downloadImage(url: url)
    }
}
