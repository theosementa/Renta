//  AppDateFieldView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI

public struct AppDateFieldView: View {

    let label: String
    let infoMessage: String?
    @Binding var date: Date
    @State private var showPicker = false

    public init(label: String, infoMessage: String? = nil, date: Binding<Date>) {
        self.label = label
        self.infoMessage = infoMessage
        self._date = date
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: .tiny) {
            Text(label)
                .font(.Body.smallRegular, color: .Text.secondary)

            Button {
                showPicker = true
            } label: {
                Text(date.formatted(date: .long, time: .omitted))
                    .font(.Body.mediumMedium, color: .Text.primary)
                    .padding(.standard)
                    .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
                    .background(Color.Background.secondary, in: .rect(cornerRadius: .standard))
            }
            .buttonStyle(.plain)

            if let info = infoMessage {
                Text(info)
                    .font(.Label.largeMedium, color: .Text.tertiary)
                    .padding(.horizontal, .tiny)
            }
        }
        .contentTransition(.numericText())
        .animation(.smooth, value: date)
        .sheet(isPresented: $showPicker) {
            DatePicker("", selection: $date, in: ...Date.now, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .presentationDetents([.medium])
        }
        .onChange(of: date) {
            showPicker.toggle()
        }
    }
}

// MARK: - Preview
#Preview("AppDateFieldView") {
    VStack(spacing: .large) {
        AppDateFieldView(label: "Purchase date", date: .constant(.now))
        AppDateFieldView(
            label: "Purchase date",
            infoMessage: "365 days ago",
            date: .constant(.now)
        )
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("AppDateFieldView — Dark") {
    VStack(spacing: .large) {
        AppDateFieldView(label: "Purchase date", date: .constant(.now))
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
