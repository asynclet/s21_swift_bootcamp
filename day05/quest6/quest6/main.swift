import Foundation
import RxSwift

let firstCollection = Observable.of("first", "second", "third")

func totalLengthOfStrings(_ firstCollection: Observable<String>) -> Observable<Int> {
    return firstCollection
        .map { $0.count }
        .reduce(0, accumulator: +)
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = totalLengthOfStrings(firstCollection)

    result.subscribe(onNext: { totalLength in
        print("Total length of strings: \(totalLength)")
    })
    .disposed(by: disposeBag)
}

main()
