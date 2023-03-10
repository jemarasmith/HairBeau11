//
//  ButtonModifiers.swift
//  HairBeau11
//
//  Created by Jemara Smith on 3/9/23.
//

import Foundation
import SwiftUI

struct ButtonModifiers: ViewModifier {
    
    func body(content: Content) -> some View {
        content
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 20)
        .padding()
        .foregroundColor(.black)
        .font(.system(size: 14, weight: .bold))
        .background(Color.white)
        .cornerRadius(5.0)
    }
}
