//
//  FoldableMakeupListView.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import SwiftUI

let screen = UIScreen.main.bounds
let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0

extension Color {
    
    static let blackPearl = Color(#colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1))
    
}

struct MakeupCellConstants {
    static let height: CGFloat = 150
    static let width: CGFloat = screen.width - 50
    
    static func height(if isSelected: Bool) -> CGFloat {
        // Extra +20 because clipShape does cut off a portion of the screen
        isSelected ? screen.height + 20 : height
    }
    
    static func maxWidth(if isSelected: Bool) -> CGFloat {
        isSelected ? .infinity : width
    }
}

fileprivate let listOffset: CGFloat = 24

struct FoldableMakeupListView: View {
    
    @State private var activeVisitIndex: Int = -1
    
    let makeups: [MakeupViewModel]
    
    private var isShowingVisit: Bool {
        activeVisitIndex != -1
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            makeupList
                // Can't do VStack because it interfere with the expand animation so I have to do a ZStack with offset
                .offset(y: isShowingVisit ? 0 : listOffset)
        }
        .ignoresSafeArea()
        .background(backgroundColor)
        .animation(.spring())
        
    }
    
    private var backgroundColor: some View {
        Color.blackPearl.saturation(1.5)
            .frame(height: screen.height + 20)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
    
}

fileprivate let listTopPadding: CGFloat = 48

private extension FoldableMakeupListView {
    
    private var makeupList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            makeupStack
                .frame(width: screen.width)
                .padding(.top, listTopPadding) // A bit of room between the label and list for the row to fold
                // Allows room to scroll up and fold rows. You will also notice that for smaller
                // lists(ones that don't fill up the entire screen height), this padding is
                // crucial because after the offset to the top of the screen,
                // the amount of clickable room is equal to the height of the list.
                // However, by adding the padding, it resolves that issue
                .padding(.bottom, 600)
        }
        
    }
    
    private var makeupStack: some View {
        VStack(spacing: 8) {
            ForEach(0..<makeups.count, id: \.self) { i in
                self.dynamicVisitRow(index: i)
                    // Because dynamic visit row is implicitly embedded inside a geometry reader
                    // through `expandableAndFoldable`, we need to explicity define the height and
                    // width of the row so the geometry reader can properly configure itself
                    .frame(height: MakeupCellConstants.height)
                    .frame(maxWidth: MakeupCellConstants.maxWidth(if: self.isShowingVisit))
            }
        }
    }
    
    private func dynamicVisitRow(index: Int) -> some View {
        makeupDetailsView(index: index, makeup: makeups[index])
            // After offsetting, you'll notice that if you don't fade the non-expanded rows,
            // the rows after the expanded row will be stacked on top of the expanded row.
            // You can also apply other transformations like scaling or offsetting non-active
            // rows for cooler effects! Play around with it!
            .opacity(isNotActiveVisit(at: index) ? 0 : 1)
            .scaleEffect(isNotActiveVisit(at: index) ? 0.5 : 1)
            .offset(x: isNotActiveVisit(at: index) ? screen.width : 0)
            .expandableAndFoldable(
                rowHeight: MakeupCellConstants.height,
                foldOffset: statusBarHeight + listOffset + listTopPadding,
                shouldFold: !isShowingVisit, // do not want to fold if a row is expanded
                isActiveIndex: isVisitIndexActive(at: index)) // used to determine which row should be expanded
    }
    
    private func makeupDetailsView(index: Int, makeup: MakeupViewModel) -> some View {
        MakeupDetailsView(selectedIndex: $activeVisitIndex, index: index, makeup: makeup)
    }
    
    private func isNotActiveVisit(at index: Int) -> Bool {
        isShowingVisit && !isVisitIndexActive(at: index)
    }
    
    private func isVisitIndexActive(at index: Int) -> Bool {
        index == activeVisitIndex
    }
    
}

struct FoldableMakeupListView_Previews: PreviewProvider {
    static var previews: some View {
        FoldableMakeupListView(makeups: [MakeupViewModel(makeup: MakeUp(id: 400, brand: "Fenty", name: "Fenty lipstick", price: "19,99", rating: 4.5, description: "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd asdas dasd as dasd asd asdasd asdasdasdasdas", image_link: ""))])
    }
}

