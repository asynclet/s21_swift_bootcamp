import Foundation
@preconcurrency import RxSwift

let firstCollection = Observable.of("meow", "gaw", "woof", "FAKE")
let filterConstant = "e"
let timeout: TimeInterval = 3

func filter(_ firstCollection: Observable<String>) -> Observable<String> {
    return firstCollection.filter { $0.lowercased().contains(filterConstant) }
}

@MainActor
func main() async {
    let disposeBag = DisposeBag()
    let filteredStrings = filter(firstCollection)

    filteredStrings.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: disposeBag)
}

Task {
    await main()
}

RunLoop.main.run(until: Date(timeIntervalSinceNow: timeout))
