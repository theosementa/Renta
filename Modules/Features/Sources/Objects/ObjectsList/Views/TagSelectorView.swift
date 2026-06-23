//  TagSelectorView.swift
//  Renta
//
//  Created by Theo Sementa on 19/06/2026.

import SwiftUI
import Models
import DesignSystem

public struct TagSelectorView: View {

    let selectedBand: ScoreBandType?
    let brandColor: Color
    let onSelect: (ScoreBandType?) -> Void

    public init(selectedBand: ScoreBandType?, brandColor: Color, onSelect: @escaping (ScoreBandType?) -> Void) {
        self.selectedBand = selectedBand
        self.brandColor = brandColor
        self.onSelect = onSelect
    }

    // MARK: - Body
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: .small) {
                allPill
                ForEach(ScoreBandType.allCasesOrdered, id: \.self) { band in
                    bandPill(band)
                }
            }
        }
    }

}

// MARK: - Subviews
fileprivate extension TagSelectorView {

    var allPill: some View {
        let label = "objects.list.filter.all".localized
        let isSelected = selectedBand == nil
        return Button {
            onSelect(nil)
        } label: {
            Text(label)
                .font(AppFont.Body.mediumMedium, color: isSelected ? Color.white : Color.Text.secondary)
                .padding(.horizontal, .medium)
                .padding(.vertical, .small)
                .background(isSelected ? brandColor : Color.Background.secondary, in: .capsule)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }

    func bandPill(_ band: ScoreBandType) -> some View {
        let label = band.label
        let isSelected = selectedBand == band
        return Button {
            onSelect(band)
        } label: {
            Text(label)
                .font(AppFont.Body.mediumMedium, color: isSelected ? Color.white : band.color)
                .padding(.horizontal, .medium)
                .padding(.vertical, .small)
                .background(isSelected ? band.color : Color.Background.secondary, in: .capsule)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }

}

// MARK: - Preview
#Preview("TagSelectorView — None selected") {
    TagSelectorView(selectedBand: nil, brandColor: .blue, onSelect: { _ in })
        .padding(.standard)
        .preferredColorScheme(.light)
}

#Preview("TagSelectorView — Excellent selected") {
    TagSelectorView(selectedBand: .excellent, brandColor: .blue, onSelect: { _ in })
        .padding(.standard)
        .preferredColorScheme(.dark)
}
