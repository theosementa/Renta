//  AddObjectStep2View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectStep2View: View {

    @Bindable var store: DefaultAddObjectStore
    @Environment(\.brandColor) private var brandColor

    // MARK: - Body
    var body: some View {
        VStack(spacing: .medium) {
            ForEach(DurationTargetType.allCases, id: \.self) { option in
                durationRow(option)
            }
        }
    }
}

// MARK: - Subviews
private extension AddObjectStep2View {

    func durationRow(_ option: DurationTargetType) -> some View {
        let isSelected = store.state.durationTarget == option
        return Button {
            store.send(.durationTargetChanged(option))
        } label: {
            HStack(spacing: .medium) {
                Group {
                    if isSelected {
                        Circle()
                            .fill(brandColor.color)
                            .overlay {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 8, height: 8)
                            }
                    } else {
                        Circle()
                            .fill(Color.Background.tertiary)
                    }
                }
                .frame(width: 20, height: 20)

                VStack(alignment: .leading, spacing: .zero) {
                    Text(option.title)
                        .font(.Body.mediumMedium, color: .Text.primary)
                    Text(option.subtitle)
                        .font(.Body.smallRegular, color: .Text.secondary)
                        .multilineTextAlignment(.leading)
                }
                .fullWidth(.leading)
            }
            .padding(.standard)
            .background(
                isSelected ? brandColor.color.opacity(0.15) : Color.Background.secondary,
                in: .rect(cornerRadius: .mediumLarge)
            )
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: .mediumLarge)
                        .stroke(brandColor.color, lineWidth: 2)
                }
            }
        }
        .animation(.smooth, value: store.state.durationTarget)
        .accessibilityLabel(option.title)
    }
}

// MARK: - DurationTargetType UI extensions
private extension DurationTargetType {
    var title: String {
        switch self {
        case .lessThan6Months:  return String(localized: "Less than 6 months", bundle: .module)
        case .sixMonthsTo1Year: return String(localized: "6 months to 1 year", bundle: .module)
        case .oneToThreeYears:  return String(localized: "1 to 3 years", bundle: .module)
        case .threeToFiveYears: return String(localized: "3 to 5 years", bundle: .module)
        case .fiveToSevenYears: return String(localized: "5 to 7 years", bundle: .module)
        case .sevenYearsOrMore: return String(localized: "7 years or more", bundle: .module)
        }
    }

    var subtitle: String {
        switch self {
        case .lessThan6Months:  return String(localized: "Seasonal items, accessories — ex. sunglasses, gardening tools", bundle: .module)
        case .sixMonthsTo1Year: return String(localized: "Everyday items with regular use — ex. shoes, small appliances", bundle: .module)
        case .oneToThreeYears:  return String(localized: "Standard durable goods — ex. laptop, camera, bike", bundle: .module)
        case .threeToFiveYears: return String(localized: "Quality equipment built to last — ex. high-end audio, e-bike", bundle: .module)
        case .fiveToSevenYears: return String(localized: "Long-term investment — ex. furniture, professional tools", bundle: .module)
        case .sevenYearsOrMore: return String(localized: "Very long lifespan — ex. vehicle, real estate equipment", bundle: .module)
        }
    }
}
