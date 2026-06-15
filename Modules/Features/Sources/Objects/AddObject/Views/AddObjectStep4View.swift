//  AddObjectStep4View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectStep4View: View {

    @Bindable var store: DefaultAddObjectStore

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: .large) {
            objectCardView

            Toggle(isOn: .init(
                get: { store.state.excludeFromGlobal },
                set: { store.send(.excludeFromGlobalChanged($0)) }
            )) {
                Text("Exclude from global statistics")
                    .font(Font.custom(fontMedium, size: 16))
                    .foregroundStyle(Color.Text.primary)
            }
            .tint(Color.Brand.main)
            .padding(.standard)
            .background(Color.Background.secondary, in: .rect(cornerRadius: 12))

            if let errorMessage = store.state.errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                    .font(Font.custom(fontRegular, size: 14))
                    .foregroundStyle(Color.Status.high)
            }
        }
    }
}

// MARK: - Subviews
private extension AddObjectStep4View {

    var objectCardView: some View {
        VStack(alignment: .leading, spacing: .large) {
            HStack(alignment: .top, spacing: .medium) {
                Text(store.state.emoji)
                    .font(.system(size: 36))
                    .frame(width: 52, height: 52)

                VStack(alignment: .leading, spacing: 6) {
                    Text(store.state.name.isEmpty ? "No name" : store.state.name)
                        .font(Font.custom(fontMedium, size: 16))
                        .foregroundStyle(Color.Text.primary)

                    if !store.state.selectedTags.isEmpty {
                        FlowLayout(spacing: .tiny) {
                            ForEach(store.state.selectedTags) { tag in
                                Text(tag.name)
                                    .font(Font.custom(fontRegular, size: 12))
                                    .foregroundStyle(Color.Text.secondary)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 6)
                                    .background(Color.Background.tertiary, in: .capsule)
                            }
                        }
                    }
                }

                Spacer()
            }

            Divider()

            VStack(alignment: .leading, spacing: .small) {
                cardInfoRow(icon: "eurosign.circle", label: store.state.purchasePrice.asCurrency)
                cardInfoRow(
                    icon: "calendar",
                    label: store.state.purchaseDate.formatted(date: .abbreviated, time: .omitted)
                )
                cardInfoRow(icon: "clock", label: store.state.durationTarget.title)
            }
        }
        .padding(.standard)
        .frame(maxWidth: .infinity, minHeight: 234)
        .background(Color.Background.secondary, in: .rect(cornerRadius: 16))
    }

    func cardInfoRow(icon: String, label: String) -> some View {
        HStack(spacing: .small) {
            Image(systemName: icon)
                .foregroundStyle(Color.Brand.main)
                .frame(width: 20)
            Text(label)
                .font(Font.custom(fontRegular, size: 14))
                .foregroundStyle(Color.Text.primary)
        }
    }
}

// MARK: - DurationTargetType UI extensions
private extension DurationTargetType {
    var title: String {
        switch self {
        case .lessThan6Months:  return "Less than 6 months"
        case .sixMonthsTo1Year: return "6 months to 1 year"
        case .oneToThreeYears:  return "1 to 3 years"
        case .threeToFiveYears: return "3 to 5 years"
        case .fiveToSevenYears: return "5 to 7 years"
        case .sevenYearsOrMore: return "7+ years"
        }
    }
}
