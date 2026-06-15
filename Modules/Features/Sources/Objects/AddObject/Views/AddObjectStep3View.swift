//  AddObjectStep3View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectStep3View: View {

    @Bindable var store: DefaultAddObjectStore

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: .standard) {
            searchBar

            if !store.state.selectedTags.isEmpty {
                VStack(alignment: .leading, spacing: .small) {
                    Text("Selected")
                        .font(Font.custom(fontRegular, size: 14))
                        .foregroundStyle(Color.Text.secondary)
                    selectedTagsChips
                }
            }

            if !store.state.tagSuggestions.isEmpty {
                VStack(spacing: 0) {
                    ForEach(store.state.tagSuggestions) { tag in
                        tagSuggestionRow(tag)
                    }
                }
                .background(Color.Background.secondary, in: .rect(cornerRadius: 12))
            }
        }
        .onAppear { store.send(.loadTags) }
    }
}

// MARK: - Subviews
private extension AddObjectStep3View {

    var searchBar: some View {
        HStack(spacing: .small) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.Text.secondary)
            TextField("Search", text: .init(
                get: { store.state.tagQuery },
                set: { store.send(.tagQueryChanged($0)) }
            ))
            .font(Font.custom(fontRegular, size: 16))
        }
        .padding(.standard)
        .frame(maxWidth: .infinity, minHeight: 52)
        .background(Color.Background.secondary, in: .rect(cornerRadius: 12))
    }

    var selectedTagsChips: some View {
        FlowLayout(spacing: .small) {
            ForEach(store.state.selectedTags) { tag in
                HStack(spacing: .tiny) {
                    Text(tag.name)
                        .font(Font.custom(fontMedium, size: 16))
                        .foregroundStyle(Color.Text.primary)
                    Button {
                        store.send(.tagRemoved(tag.id))
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.Text.secondary)
                    }
                    .accessibilityLabel("Remove \(tag.name)")
                }
                .padding(.vertical, .small)
                .padding(.horizontal, .medium)
                .background(Color.Background.secondary, in: .capsule)
            }
        }
    }

    func tagSuggestionRow(_ tag: TagModelDomain) -> some View {
        let isLast = store.state.tagSuggestions.last?.id == tag.id
        return VStack(spacing: 0) {
            Button {
                store.send(.tagAdded(tag))
            } label: {
                Text(tag.name)
                    .font(Font.custom(fontRegular, size: 16))
                    .foregroundStyle(Color.Text.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.standard)
                    .frame(minHeight: 52)
            }
            .buttonStyle(.plain)
            if !isLast {
                Divider()
                    .padding(.leading, .standard)
            }
        }
    }
}
