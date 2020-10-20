//
//  ContentView.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var makeupListVM = MakeupListViewModel()
    //    @State private var brandQuery: String = ""
    
    init() {
        makeupListVM.load()
    }
    
    var body: some View {
        
        //        let filteredMakeups = self.makeupListVM.searchTerm.isEmpty ? self.makeupListVM.makeups : self.makeupListVM.makeups.filter { $0.brand.starts(with: self.makeupListVM.searchTerm ) }
        
        return VStack {
            //                SearchBar(text: self.$brandQuery)
//            SearchView(searchTerm: self.$makeupListVM.searchTerm)
            FoldableMakeupListView(makeups: makeupListVM.makeups).padding()
                
            //                MakeupListView(makeups: makeupListVM.makeups)
            
        }
        //            NavigationView {
        //            VStack {
        ////                SearchBar(text: self.$brandQuery)
        //                SearchView(searchTerm: self.$makeupListVM.searchTerm)
        //                FoldableMakeupListView(makeups: makeupListVM.makeups)
        ////                MakeupListView(makeups: makeupListVM.makeups)
        //
        //            }
        //            .navigationBarTitle("Makeups")
        //        }.edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
