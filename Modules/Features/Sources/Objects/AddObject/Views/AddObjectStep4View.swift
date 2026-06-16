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
        VStack(alignment: .leading, spacing: .standard) {
            objectCardView
            costPreviewCard

            if let errorMessage = store.state.errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                    .font(AppFont.Body.smallRegular, color: .Status.high)
            }
        }
    }
}

// MARK: - Subviews
private extension AddObjectStep4View {

    var objectCardView: some View {
        VStack(alignment: .leading, spacing: .standard) {
            header
            Divider()
            detailRows
        }
        .padding(.standard)
        .background(Color.Background.secondary, in: .rect(cornerRadius: .mediumLarge))
    }

    var header: some View {
        HStack(spacing: .small) {
            Text(store.state.emoji)
                .font(.system(size: 20))
                .padding(.small)
                .background(store.state.scoreBand.color.opacity(0.15), in: .rect(cornerRadius: .small))

            VStack(alignment: .leading, spacing: 4) {
                Text(store.state.name.isEmpty ? "No name" : store.state.name)
                    .font(AppFont.Body.largeMedium, color: .Text.primary)

                if !store.state.tagsDisplay.isEmpty {
                    Text(store.state.tagsDisplay)
                        .font(AppFont.Label.largeMedium, color: .Text.secondary)
                }
            }

            Spacer()
        }
    }

    var detailRows: some View {
        VStack(spacing: .standard) {
            detailRow(label: "Purchase price", value: store.state.purchasePrice.asCurrency)
            Divider()
            detailRow(label: "Purchase date", value: store.state.purchaseDate.formatted(date: .abbreviated, time: .omitted))
            Divider()
            detailRow(label: "Owned for", value: store.state.ownedForDisplay)
        }
    }

    func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
                .font(AppFont.Body.smallRegular, color: .Text.secondary)
            Spacer()
            Text(value)
                .font(AppFont.Body.mediumMedium, color: .Text.primary)
        }
    }

    @ViewBuilder
    var costPreviewCard: some View {
        if store.state.hasCostPreview {
            HStack(spacing: .large) {
                if store.state.showCostPerDay {
                    costColumn(value: store.state.costPerDay.asCurrency, label: "per day")
                }
                if store.state.showCostPerMonth {
                    costColumn(value: store.state.costPerMonth.asCurrency, label: "per month")
                }
                if store.state.showCostPerYear {
                    costColumn(value: store.state.costPerYear.asCurrency, label: "per year")
                }
                Spacer()
            }
            .padding(.standard)
            .background(store.state.scoreBand.color.opacity(0.15), in: .rect(cornerRadius: .mediumLarge))
        }
    }

    func costColumn(value: String, label: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(value)
                .font(AppFont.Title.largeSemiBold, color: store.state.scoreBand.color)
            Text(label)
                .font(AppFont.Label.largeMedium, color: store.state.scoreBand.color)
        }
    }
}
