import Foundation
@preconcurrency import RxSwift

let firstCollection = Observable.of("first", "second", "third")
let prefix = "th"
let timeout: TimeInterval = 3

func filter(_ firstCollection: Observable<String>) -> Observable<String> {
    firstCollection.filter { $0.hasPrefix(prefix) }
}

@MainActor
func main() async {
    let filtredStrings = filter(firstCollection)

    filtredStrings.subscribe(onNext: { value in
        print(value)
    })
    .disposed(by: DisposeBag())
}

Task {
    await main()
}

RunLoop.current.run(until: Date(timeIntervalSinceNow: timeout))
