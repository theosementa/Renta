//  AddObjectStep2View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectStep2View: View {

    @Bindable var store: DefaultAddObjectStore

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
                            .fill(Color.Brand.main)
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
                isSelected ? Color.Brand.main.opacity(0.15) : Color.Background.secondary,
                in: .rect(cornerRadius: .mediumLarge)
            )
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: .mediumLarge)
                        .stroke(Color.Brand.main, lineWidth: 2)
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
        case .lessThan6Months:  return "Less than 6 months"
        case .sixMonthsTo1Year: return "6 months to 1 year"
        case .oneToThreeYears:  return "1 to 3 years"
        case .threeToFiveYears: return "3 to 5 years"
        case .fiveToSevenYears: return "5 to 7 years"
        case .sevenYearsOrMore: return "7 years or more"
        }
    }

    var subtitle: String {
        switch self {
        case .lessThan6Months:  return "Seasonal items, accessories — ex. sunglasses, gardening tools"
        case .sixMonthsTo1Year: return "Everyday items with regular use — ex. shoes, small appliances"
        case .oneToThreeYears:  return "Standard durable goods — ex. laptop, camera, bike"
        case .threeToFiveYears: return "Quality equipment built to last — ex. high-end audio, e-bike"
        case .fiveToSevenYears: return "Long-term investment — ex. furniture, professional tools"
        case .sevenYearsOrMore: return "Very long lifespan — ex. vehicle, real estate equipment"
        }
    }
}
