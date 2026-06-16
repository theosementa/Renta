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
        case .lessThan6Months:  return "duration.lessThan6Months".localized
        case .sixMonthsTo1Year: return "duration.sixMonthsTo1Year".localized
        case .oneToThreeYears:  return "duration.oneToThreeYears".localized
        case .threeToFiveYears: return "duration.threeToFiveYears".localized
        case .fiveToSevenYears: return "duration.fiveToSevenYears".localized
        case .sevenYearsOrMore: return "duration.sevenYearsOrMore".localized
        }
    }

    var subtitle: String {
        switch self {
        case .lessThan6Months:  return "duration.lessThan6Months.subtitle".localized
        case .sixMonthsTo1Year: return "duration.sixMonthsTo1Year.subtitle".localized
        case .oneToThreeYears:  return "duration.oneToThreeYears.subtitle".localized
        case .threeToFiveYears: return "duration.threeToFiveYears.subtitle".localized
        case .fiveToSevenYears: return "duration.fiveToSevenYears.subtitle".localized
        case .sevenYearsOrMore: return "duration.sevenYearsOrMore.subtitle".localized
        }
    }
}
