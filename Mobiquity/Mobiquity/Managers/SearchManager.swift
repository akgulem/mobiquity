//
//  SearchManager.swift
//  Mobiquity
//
//  Created by Emrah Akgül on 7.01.2022.
//

import Foundation

protocol SearchManageable {

    var numberOfSearchHistories: Int { get }
    func getSearchHistoryItem(at index: Int) -> String
    func saveSearchHistoryItem(item: String)
}

private enum Constants {

    static let keyPath = "searchHistoryItems"
}

final class SearchManager: SearchManageable {

    static let shared = SearchManager()
    private let keyPath = Constants.keyPath
    private let queue = DispatchQueue(label: "project.tryout.emrahakgul.mobiquity.queue")

    private var historyItems: [String] {
        if let items = UserDefaults.standard.object(forKey: keyPath) as? [String] {
            return items
        } else {
            return [String]()
        }
    }

    private init() {}

    var numberOfSearchHistories: Int {
        return historyItems.count
    }

    func getSearchHistoryItem(at index: Int) -> String {
        guard !historyItems.isEmpty, index < historyItems.count else {
            return ""
        }
        return historyItems[index]
    }

    func saveSearchHistoryItem(item: String) {
        var items = historyItems
        guard !items.contains(item), !item.isEmpty else {
            return
        }
        items.append(item)
        UserDefaults.standard.set(items, forKey: keyPath)
    }

}
