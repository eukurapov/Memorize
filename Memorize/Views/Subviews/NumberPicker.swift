//
//  NumberPicker.swift
//  Memorize
//
//  Created by Eugene Kurapov on 16.07.2020.
//  Copyright © 2020 Evgeniy Kurapov. All rights reserved.
//

import SwiftUI

struct NumberPicker: View {
    
    @Binding var number: Int
    var max: Int
    
    var body: some View {
        HStack {
            Text("\(number) pairs")
            Spacer()
            Stepper("", value: $number, in: 2...max)
        }
        .onAppear {
            if self.number > self.max {
                self.number = self.max
            }
        }
    }
    
}
