//  DefaultAddObjectStore.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import DataSources
import Models

@Observable @MainActor
public final class DefaultAddObjectStore: @MainActor AddObjectStore {

    public private(set) var state: AddObjectState
    private let reducer = AddObjectReducer()
    private let itemDataSource: ItemDataSource
    private let tagDataSource: TagDataSource

    private let _sideEffects = AsyncStream<AddObjectSideEffect>.makeStream()
    public var sideEffects: AsyncStream<AddObjectSideEffect> { _sideEffects.stream }

    private var submitTask: Task<Void, Never>?
    private var loadTagsTask: Task<Void, Never>?
    private var createTagTask: Task<Void, Never>?
    private var deleteTagTask: Task<Void, Never>?

    public init() {
        self.state = .init()
        self.itemDataSource = ItemDataSource.shared
        self.tagDataSource = TagDataSource()
    }

    public init(
        state: AddObjectState,
        itemDataSource: ItemDataSource,
        tagDataSource: TagDataSource
    ) {
        self.state = state
        self.itemDataSource = itemDataSource
        self.tagDataSource = tagDataSource
    }

}

// MARK: - Public methods
public extension DefaultAddObjectStore {

    func send(_ intent: AddObjectIntent) {
        switch intent {

        case .nextStep:
            let nextRawValue = state.step.rawValue + 1
            guard let nextStep = AddObjectStep(rawValue: nextRawValue) else { return }
            state = reducer.reduce(state: state, result: .stepChanged(nextStep))

        case .previousStep:
            let prevRawValue = state.step.rawValue - 1
            if let prevStep = AddObjectStep(rawValue: prevRawValue) {
                state = reducer.reduce(state: state, result: .stepChanged(prevStep))
            } else {
                emit(.dismiss)
            }

        case .nameChanged(let value):
            state = reducer.reduce(state: state, result: .nameChanged(value))

        case .emojiChanged(let value):
            state = reducer.reduce(state: state, result: .emojiChanged(value))

        case .priceChanged(let value):
            state = reducer.reduce(state: state, result: .priceChanged(value))

        case .purchaseDateChanged(let value):
            state = reducer.reduce(state: state, result: .purchaseDateChanged(value))

        case .durationTargetChanged(let value):
            state = reducer.reduce(state: state, result: .durationTargetChanged(value))

        case .tagQueryChanged(let value):
            state = reducer.reduce(state: state, result: .tagQueryChanged(value))
            loadTagsTask?.cancel()
            loadTagsTask = Task { await execute(.loadTags) }

        case .tagCreated(let name):
            createTagTask?.cancel()
            createTagTask = Task { await execute(.createTag(name)) }

        case .tagAdded(let tag):
            state = reducer.reduce(state: state, result: .tagAdded(tag))
            loadTagsTask?.cancel()
            loadTagsTask = Task { await execute(.loadTags) }

        case .tagRemoved(let id):
            state = reducer.reduce(state: state, result: .tagRemoved(id))
            loadTagsTask?.cancel()
            loadTagsTask = Task { await execute(.loadTags) }

        case .tagDeleted(let id):
            deleteTagTask?.cancel()
            deleteTagTask = Task { await execute(.deleteTag(id)) }

        case .loadTags:
            loadTagsTask?.cancel()
            loadTagsTask = Task { await execute(.loadTags) }

        case .submit:
            guard !state.name.trimmingCharacters(in: .whitespaces).isEmpty else {
                state = reducer.reduce(state: state, result: .failed(.unknown(AddObjectError.emptyName.description)))
                return
            }
            guard state.purchasePrice > 0 else {
                state = reducer.reduce(state: state, result: .failed(.unknown(AddObjectError.invalidPrice.description)))
                return
            }
            submitTask?.cancel()
            submitTask = Task {
                await execute(.submit(
                    name: state.name,
                    emoji: state.emoji,
                    purchasePrice: state.purchasePrice,
                    purchaseDate: state.purchaseDate,
                    durationTarget: state.durationTarget,
                    tags: state.selectedTags
                ))
            }    

        case .dismiss:
            emit(.dismiss)
        }
    }

}

// MARK: - Private methods
private extension DefaultAddObjectStore {

    func execute(_ action: AddObjectAction) async {
        switch action {

        case .loadTags:
            if tagDataSource.tags.isEmpty {
                do {
                    try await tagDataSource.fetchTags()
                } catch {
                    state = reducer.reduce(state: state, result: .failed(.unknown(error.localizedDescription)))
                    return
                }
            }
            let selectedIds = Set(state.selectedTags.map(\.id))
            let suggestions = tagDataSource.suggestions(for: state.tagQuery)
                .filter { !selectedIds.contains($0.id) }
            state = reducer.reduce(state: state, result: .tagSuggestionsLoaded(suggestions))

        case .createTag(let name):
            do {
                let tag = try await tagDataSource.add(name: name)
                state = reducer.reduce(state: state, result: .tagAdded(tag))
            } catch {
                state = reducer.reduce(state: state, result: .failed(.unknown(error.localizedDescription)))
            }

        case .deleteTag(let id):
            do {
                try await tagDataSource.delete(id: id)
                state = reducer.reduce(state: state, result: .tagDeleted(id))
            } catch {
                state = reducer.reduce(state: state, result: .failed(.unknown(error.localizedDescription)))
            }

        case let .submit(name, emoji, purchasePrice, purchaseDate, durationTarget, tags):
            state = reducer.reduce(state: state, result: .loading)
            do {
                let domain = try await itemDataSource.add(
                    name: name,
                    emoji: emoji,
                    purchasePrice: purchasePrice,
                    purchaseDate: purchaseDate,
                    durationTarget: durationTarget,
                    tags: tags
                )
                state = reducer.reduce(state: state, result: .submitted(domain))
                emit(.objectAdded(domain))
                emit(.dismiss)
            } catch let error as AppError {
                state = reducer.reduce(state: state, result: .failed(error))
                if case .freeTierLimit = error {
                    emit(.showProUpgrade)
                }
            } catch {
                state = reducer.reduce(state: state, result: .failed(.unknown(error.localizedDescription)))
            }
        }
    }

    func emit(_ effect: AddObjectSideEffect) {
        _sideEffects.continuation.yield(effect)
    }

}
