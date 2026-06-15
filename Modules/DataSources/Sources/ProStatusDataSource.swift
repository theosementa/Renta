//  ProStatusDataSource.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import StoreKit

@Observable @MainActor
public final class ProStatusDataSource {

    public static let shared = ProStatusDataSource()

    public private(set) var isPro: Bool = false

    private var updateListenerTask: Task<Void, Never>?

    private init() {
        updateListenerTask = startTransactionListener()
    }

    deinit {
        updateListenerTask?.cancel()
    }

}

// MARK: - Public methods
public extension ProStatusDataSource {

    func checkCurrentStatus() async {
        var foundPro = false
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productID == "com.renta.app.pro",
               transaction.revocationDate == nil {
                foundPro = true
                break
            }
        }
        isPro = foundPro
    }

}

// MARK: - Private methods
private extension ProStatusDataSource {

    func startTransactionListener() -> Task<Void, Never> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                if case .verified(let transaction) = result {
                    if transaction.productID == "com.renta.app.pro" {
                        await MainActor.run {
                            self.isPro = transaction.revocationDate == nil
                        }
                    }
                    await transaction.finish()
                }
            }
        }
    }

}
