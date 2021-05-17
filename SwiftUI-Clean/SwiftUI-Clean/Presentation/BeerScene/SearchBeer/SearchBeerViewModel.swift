//
//  SearchBeerViewModel.swift
//  SwiftUI-MV
//
//  Created by GoEun Jeong on 2021/05/13.
//

import Combine
import Foundation

class SearchBeerViewModel: ObservableObject {
    @Published var beer = Beer(id: nil, name: "Please Search Beer By ID", description: nil, imageURL: nil)
    @Published var text = ""
    @Published var isEditing = false
    @Published var isLoading = false
    @Published var isErrorAlert = false
    @Published var errorMessage = ""

    private var bag = Set<AnyCancellable>()
    private let searchBeerUseCase: SearchBeerUseCase

    init(searchBeerUseCase: SearchBeerUseCase) {
        self.searchBeerUseCase = searchBeerUseCase
        bindInputs()
        bindOutputs()
    }

    deinit {
        bag.removeAll()
    }

    // MARK: Input

    enum Input {
        case search
    }

    private let searchSubject = PassthroughSubject<Int, Never>()

    private let beerSubject = PassthroughSubject<[Beer], Never>()
    private let isLoadingSubject = PassthroughSubject<Bool, Never>()
    private let errorSubject = PassthroughSubject<Error, Never>()

    func apply(_ input: Input) {
        switch input {
        case .search:
            searchSubject.send(Int(text) ?? 0)
        }
    }

    func bindInputs() {
        searchSubject
            .flatMap { [searchBeerUseCase] id in
                searchBeerUseCase.execute(id: id)
                    .catch { [weak self] error -> Empty<[Beer], Never> in
                        self?.errorSubject.send(error)
                        return .init()
                    }
            }.share()
            .subscribe(beerSubject)
            .store(in: &bag)

        searchSubject
            .map { _ in true }
            .share()
            .subscribe(isLoadingSubject)
            .store(in: &bag)
    }

    func bindOutputs() {
        isLoadingSubject
            .assign(to: \.isLoading, on: self)
            .store(in: &bag)

        beerSubject
            .map { _ in false }
            .assign(to: \.isLoading, on: self)
            .store(in: &bag)

        beerSubject
            .map { $0.first! }
            .assign(to: \.beer, on: self)
            .store(in: &bag)

        errorSubject
            .map { _ in false }
            .assign(to: \.isLoading, on: self)
            .store(in: &bag)

        errorSubject
            .map { _ in true }
            .assign(to: \.isErrorAlert, on: self)
            .store(in: &bag)

        errorSubject
            .map { $0.localizedDescription }
            .assign(to: \.errorMessage, on: self)
            .store(in: &bag)
    }
}
