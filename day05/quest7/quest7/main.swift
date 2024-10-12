import Foundation
import RxSwift

let firstCollection = Observable.of("first", "second", "third")

func countStrings(_ firstCollection: Observable<String>) -> Observable<Int> {
    firstCollection.reduce(0) { count, _ in count + 1 }
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = countStrings(firstCollection)

    result.subscribe(onNext: { count in
        print("Number of strings in the collection: \(count)")
    }).disposed(by: disposeBag)
}

main()
