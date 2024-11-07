//
//  AisleTabView.swift
//  aisle
//
//  Created by Varun Adit on 11/7/24.
//

import SwiftUI
import ComposableArchitecture
import SharedModels
import AisleUI

public struct AisleTabView: View {
    @Environment(\.colorScheme) var colorScheme
    @Namespace var animation
    var parentGeometry: GeometryProxy
    
    @State private var midPoint: CGFloat = 1.0
    
    @Bindable var store: StoreOf<TabReducer>
    
    public init(store: StoreOf<TabReducer>, proxy: GeometryProxy) {
        self.store = store
        self.parentGeometry = proxy
    }
    
    public var body: some View {
        
        let screenHeight = parentGeometry.size.height
        let screenWidth = parentGeometry.size.width
        let iconH: CGFloat = screenWidth * (200/1000)
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.aisleDemoBackground)
            
            Group {
                GeometryReader { geometry in
                    WithPerceptionTracking {
                        HStack(alignment: .top, spacing: 0) {
                            ForEach(0..<TabModel.allCases.count) { index in
                                GeometryReader { childProxy in
                                    WithPerceptionTracking {
                                        let tab = TabModel.allCases[index]
                                        let isCurrent = store.selectedTab.id == index + 1
                                        Button(.medium) {
                                            store.send(.didSelectTab(tab), animation: Animation.spring)
                                        } label: {
                                            VStack(spacing: 2.0) {
                                                Image(systemName: tab.selectedSystemImage)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .aspectRatio(0.7,
                                                                 contentMode: .fit)
                                                    .frame(width: 35, height: 35)
                                                    .scaleEffect(1.0)
                                                    .fontWeight(isCurrent ?  .medium : .regular)
                                                    .foregroundColor(isCurrent ? .black : .gray)
                                                    .padding()
                                                    .compositingGroup()
                                            }
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: iconH)
        .ignoresSafeArea(.container, edges: .bottom)

    }
}
