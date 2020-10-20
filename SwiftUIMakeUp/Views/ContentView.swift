//
//  ContentView.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var makeupListVM = MakeupListViewModel()
    
    init() {
        makeupListVM.load()
    }
    
    var body: some View {
         VStack {
            FoldableMakeupListView(makeups: makeupListVM.makeups).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
