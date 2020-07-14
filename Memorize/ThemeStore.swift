//
//  ThemeStore.swift
//  Memorize
//
//  Created by Eugene Kurapov on 14.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI
import Combine

class ThemeStore: ObservableObject {
    
    private static let themesKey = "ThemeStore.Default"
    
    @Published var themes: [Theme]
    
    private var autosave: AnyCancellable?
    
    init() {
        if let userdata = UserDefaults.standard.array(forKey: ThemeStore.themesKey) as? [Data] {
            themes = [Theme](fromDataArray: userdata)
        } else {
            themes = Theme.defaults
        }
        autosave = $themes.sink { value in
            UserDefaults.standard.set(value.map { $0.json } , forKey: ThemeStore.themesKey)
        }
    }
    
}

extension Array where Element == Theme {
    
    var asDataArray: [Data] {
        var data = [Data]()
        for element in self {
            if let json = element.json {
                data.append(json)
            }
        }
        return data
    }
    
    init(fromDataArray data: [Data]) {
        self.init()
        for json in data {
            if let theme = Theme.init(from: json) {
                self.append(theme)
            }
        }
    }
    
}
