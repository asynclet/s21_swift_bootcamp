import Foundation
import RxSwift

struct Item {
    let id: Int
    let value: String
}

let secondCollection = Observable.of(
    Item(id: 1, value: "text1"),
    Item(id: 2, value: "text2"),
    Item(id: 1, value: "text3"),
    Item(id: 2, value: "text4"),
    Item(id: 3, value: "text5")
)

func groupById(_ collection: Observable<Item>) -> Observable<[Int: [Item]]> {
    return collection
        .groupBy { $0.id }
        .flatMap { group -> Observable<(Int, [Item])> in
            group
                .toArray()
                .map { (group.key, $0) }
                .asObservable()
        }
        .toArray()
        .map { groupedItems in
            var dict = [Int: [Item]]()
            for (id, items) in groupedItems {
                dict[id] = items
            }
            return dict
        }
        .asObservable()
}

@MainActor
func main() {
    let disposeBag = DisposeBag()
    let result = groupById(secondCollection)

    result.subscribe(onNext: { groupedDict in
        print("Grouped items by id: \(groupedDict)")
    }).disposed(by: disposeBag)
}

main()
