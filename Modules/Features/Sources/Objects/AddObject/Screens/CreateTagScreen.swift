//  CreateTagScreen.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem

struct CreateTagScreen: View {

    let onConfirm: (String) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var tagName = ""

    private var isSaveDisabled: Bool {
        tagName.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                AppTextFieldView(
                    label: "Tag name",
                    placeholder: "Personal, Work, Gift…",
                    text: $tagName
                )
                .padding(.large)
                Spacer()
            }
            .background(Color.Background.primary)
            .navigationTitle("Create tag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                    .font(AppFont.Body.mediumMedium, color: .Text.primary)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        onConfirm(tagName.trimmingCharacters(in: .whitespaces))
                        dismiss()
                    }
                    .font(AppFont.Body.mediumMedium, color: .Brand.main)
                    .fontWeight(.semibold)
                    .disabled(isSaveDisabled)
                    .opacity(isSaveDisabled ? 0.4 : 1)
                }
            }
        }
        .presentationDetents([.medium])
    }
}

// MARK: - Preview
#Preview("CreateTagScreen") {
    CreateTagScreen { tagName in
        print("Created: \(tagName)")
    }
}
