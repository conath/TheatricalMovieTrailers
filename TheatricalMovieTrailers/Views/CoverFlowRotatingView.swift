//
//  CoverFlowRotatingView.swift
//  TheatricalMovieTrailers
//
//  Created by Chris on 16.10.20.
//

import SwiftUI

struct CoverFlowRotatingView<Content: View>: View {
    @State var envGeo: GeometryProxy
    @State var content: Content
    
    var body: some View {
        GeometryReader { myGeo in
            content
                .offset(x: getOffsetX(envGeo, myGeo), y: getOffsetY(envGeo, myGeo))
                .rotation3DEffect(getRotationAngle(envGeo, myGeo), axis: (x: 0, y: 0.5, z: 0))
        }
    }
    
    private func getOffsetX(_ geo: GeometryProxy, _ myGeo: GeometryProxy) -> CGFloat {
        let centerX = myGeo.frame(in: .global).midX
        let halfW = geo.frame(in: .local).midX
        // maps from -50% to 50%
        let percentW = (centerX - halfW) / geo.size.width
        let baseValue: CGFloat = 10
        return baseValue * percentW
    }
    
    private func getOffsetY(_ geo: GeometryProxy, _ myGeo: GeometryProxy) -> CGFloat {
        let centerX = myGeo.frame(in: .global).midX
        let halfW = geo.frame(in: .local).midX
        // maps from -50% to 50%
        let percentW = (centerX - halfW) / geo.size.width
        let baseValue: CGFloat = -10
        return baseValue * abs(percentW)
    }
    
    private func getRotationAngle(_ geo: GeometryProxy, _ myGeo: GeometryProxy) -> Angle {
        let centerX = myGeo.frame(in: .global).midX
        let halfW = geo.frame(in: .local).midX
        // maps from -50% to 50%
        let percentW = Double((centerX - halfW) / geo.size.width)
        let baseAngle: Double = -90
        return .degrees(percentW * baseAngle)
    }
}

#if DEBUG
struct CoverFlowRotatingView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: true, content: {
                ForEach(0..<3) { _ in
                    GeometryReader { myGeo in
                        CoverFlowRotatingView(envGeo: geo, content:
                            EmptyView()
                        )
                    }
                }
            })
        }
    }
}
#endif
