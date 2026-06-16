//  AddObjectStep3View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectStep3View: View {

    @Bindable var store: DefaultAddObjectStore

    @State private var showCreateTag = false

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: .large) {
            searchBar

            if !store.state.selectedTags.isEmpty {
                selectedSection
            }

            tagListCard
        }
        .onAppear { store.send(.loadTags) }
        .sheet(isPresented: $showCreateTag) {
            CreateTagScreen { tagName in
                store.send(.tagCreated(tagName))
            }
        }
    }
}

// MARK: - Subviews
private extension AddObjectStep3View {

    var searchBar: some View {
        AppSearchBarView(
            placeholder: "Search",
            text: .init(
                get: { store.state.tagQuery },
                set: { store.send(.tagQueryChanged($0)) }
            )
        )
    }

    var selectedSection: some View {
        VStack(alignment: .leading, spacing: .small) {
            Text("Selected")
                .font(AppFont.Body.smallRegular, color: .Text.secondary)
            FlowLayout(spacing: .medium) {
                ForEach(store.state.selectedTags) { tag in
                    tagChip(tag)
                }
            }
        }
    }

    func tagChip(_ tag: TagModelDomain) -> some View {
        HStack(spacing: .tiny) {
            Text(tag.name)
                .font(AppFont.Body.mediumMedium, color: .Brand.main)
            Button {
                store.send(.tagRemoved(tag.id))
            } label: {
                IconView(.iconXmark, size: 16, color: .Brand.main)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Remove \(tag.name)")
        }
        .padding(.horizontal, .medium)
        .padding(.vertical, .small)
        .background(Color.Brand.main.opacity(0.15), in: .capsule)
    }

    var tagListCard: some View {
        VStack(spacing: 0) {
            createNewTagRow
            if !store.state.tagSuggestions.isEmpty {
                Divider()
            }
            ForEach(Array(store.state.tagSuggestions.enumerated()), id: \.element.id) { index, tag in
                tagSuggestionRow(tag)
                if index < store.state.tagSuggestions.count - 1 {
                    Divider()
                }
            }
        }
        .background(Color.Background.secondary, in: .rect(cornerRadius: .large))
    }

    var createNewTagRow: some View {
        Button {
            showCreateTag = true
        } label: {
            HStack(spacing: .small) {
                IconView(.iconPlus, size: .large, color: .Brand.main)
                Text("Create new tag")
                    .font(AppFont.Body.mediumMedium, color: .Brand.main)
            }
            .fullWidth(.leading)
            .padding(.standard)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Create new tag")
    }

    func tagSuggestionRow(_ tag: TagModelDomain) -> some View {
        Button {
            store.send(.tagAdded(tag))
        } label: {
            Text(tag.name)
                .font(AppFont.Body.mediumRegular, color: .Text.primary)
                .fullWidth(.leading)
                .padding(.standard)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .contextMenu {
            Button(role: .destructive) {
                store.send(.tagDeleted(tag.id))
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}
