//
//  MakeupDetailsView.swift
//  SwiftUIMakeUp
//
//  Created by Deniz Tutuncu on 10/19/20.
//

import SwiftUI

extension AnyTransition {
    
    static var scaleFade: AnyTransition {
        AnyTransition.scale.combined(with: .opacity)
    }
    
}

struct MakeupDetailsView: View {
    
    @Binding var selectedIndex: Int
    
    let index: Int
    let makeup: MakeupViewModel
    
    private var isSelected: Bool {
        selectedIndex == index
    }
    
    var body: some View {
        makeupDetailsView
            .animation(.spring())
            .padding(.top, isSelected ? 12 : 24)
            .padding(.horizontal, isSelected ? 0 : 40)
            .frame(height: MakeupCellConstants.height(if: isSelected))
            .frame(maxWidth: MakeupCellConstants.maxWidth(if: isSelected))
            .edgesIgnoringSafeArea(.all)
            .background(Color.white)
            .foregroundColor(Color.primary)
            .clipShape(RoundedRectangle(cornerRadius: isSelected ? 30 : 10, style: .continuous))
            .animation(.easeInOut) // we want an easeInOut to be applied to the expanding animation
            .onTapGesture(perform: setSelectedVisitIndex)
            .exitOnDrag(if: isSelected, onExit: unselectRow, isSimultaneous: true) // simultaneous because there's a scrollview embedded inside
            .border(Color.white, width: 2)
    }
    
    private func setSelectedVisitIndex() {
        selectedIndex = index
    }
    
    private func unselectRow() {
        selectedIndex = -1
    }
}

private extension MakeupDetailsView {
    
    private var makeupDetailsView: some View {
        VStack(spacing: 8) {
            
            HStack {
                VStack {
                    header
                        .padding(.top, isSelected ? 20 : 20)
                        .padding(.horizontal, isSelected ? 30 : 0)
                    
                    HStack(alignment: .center) {
                        coreDetailsView
                        Spacer()
                    }
                }
    
                Spacer()
                makeupImage
            }.padding()
            
            if isSelected {
                
                HStack {
                    Spacer()
                    makeupPrice
                    Spacer()
                }
                .padding()
                
                makeupDescriptionTextView
                    .padding(.horizontal)
                    .transition(.opacity)
                    .id("\(self.makeup.id)\(self.isSelected)")
            }
            Spacer()
        }
        .padding( isSelected ? EdgeInsets(top: 32, leading: 0, bottom: 0, trailing: 0) : EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .foregroundColor(.white)
    }
    
    private var header: some View {
        HStack(alignment: .center) {
            if isSelected {
                backButton
                    .transition(.scaleFade)
            }
            brandNameText
                .transition(.scaleFade)
                .id("\(makeup.brand)\(isSelected)")
            Spacer()
        }
    }
    
    private var backButton: some View {
        Button(action: unselectRow) {
            backButtonImage
        }
        .foregroundColor(Color.primary)
    }
    
    private var backButtonImage: Image {
        Image(systemName: "arrow.left")
    }
    
    private var makeupImage: some View {
        URLImage(url: makeup.imageLink)
            .scaledToFit()
            .frame(width: 100, height: 150)
            .clipShape(Circle())
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 5, x: 5, y: 5)
            .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 5, x: -5, y: -5)
            .padding()
    }
    
    private var makeupPrice: some View {
        Text("\(makeup.price)")
            .foregroundColor(Color.white)
            .font(.custom("Arial",size: 22))
            .frame(width: 75)
            .padding(10)
            .background(Color(#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)))
            .foregroundColor(Color.primary)
            .cornerRadius(6)
            .lineLimit(0)
            .minimumScaleFactor(0.5)
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 2, x: 2, y: 2)
            .shadow(color: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), radius: 2, x: -2, y: -2)
    }
    
    private var brandNameText: some View {
        Text(makeup.brand)
            .font(isSelected ? .system(size: 32) : .body)
            .fontWeight(isSelected ? .bold : .regular)
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.primary)
    }
    
    private var coreDetailsView: some View {
        Group {
            makeupNameText
                .transition(.scaleFade)
                .id("\(makeup.name)\(isSelected)")
        }
    }
    
    private var makeupNameText: some View {
        Text(makeup.name)
            .font(isSelected ? .system(size: 24) : .system(size: 16))
            .tracking(isSelected ? 2 : 0)
            .foregroundColor(isSelected ? Color.primary : Color.secondary)
            .minimumScaleFactor(isSelected ? 1 : 0.5)
            .lineLimit(isSelected ? nil : 4)
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 8, trailing: 0))
            .multilineTextAlignment(.leading)
    }
    
    
    private var makeupDescriptionTextView: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: true) {
                if isSelected {
                    Text(self.makeup.description)
                        .font(self.isSelected ? .body : .caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(self.isSelected ? nil : 1)
                        .multilineTextAlignment(.leading)
                        .frame(width: geometry.size.width)
                        .padding()
                        .foregroundColor(Color.primary)
                }
            }
        }
    }
}

struct MakeupDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MakeupDetailsView(selectedIndex: .constant(1), index: 1, makeup: MakeupViewModel(makeup: MakeUp(id: 400, brand: "Fenty", name: "Fenty lipstick", price: "19,99", rating: 4.5, description: "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd asdas dasd as dasd asd asdasd asdasdasdasdas", image_link: "")))
            MakeupDetailsView(selectedIndex: .constant(1), index: 1, makeup: MakeupViewModel(makeup: MakeUp(id: 401, brand: "Fenty", name: "Fenty lipstick", price: "19,99", rating: 4.5, description: "asdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasd asdas dasd as dasd asd asdasd asdasdasdasdas", image_link: "")))
            
        }
    }
}
