//
//  MakeupListViewModel.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import Foundation

class MakeupListViewModel: ObservableObject {
    
    @Published var makeups: [MakeupViewModel] = [MakeupViewModel]()
    @Published var searchTerm: String = "Maybelline"
    
    func load() {
        fetchMakeups()
    }
    
    private func fetchMakeups() {
        Webservice().fetchMakeup(queryBrand: self.searchTerm) { makeups in
            if let makeups = makeups {
                DispatchQueue.main.async {
                    self.makeups = makeups.map(MakeupViewModel.init)
                }
            }
        }
    }
}
