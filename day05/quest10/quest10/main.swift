import Foundation
import RxSwift

protocol ItemID {
    var id: Int { get }
}
struct Item: ItemID {
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

func groupAndCountById<Item: ItemID>(_ secondCollection: Observable<Item>) -> any Disposable {
    secondCollection
        .groupBy { $0.id }
        .flatMap { (group: GroupedObservable<Int, Item>) -> PrimitiveSequence<SingleTrait, (Int, Int)> in
            return group
                .toArray()
                .map { samples in
                    return (group.key, samples.count)
                }
        }
        .subscribe(onNext: { (id: Int, count: Int) in
            print("Group ID: \(id) has \(count) elements")
        })
}

@MainActor
func main() async {
    groupAndCountById(secondCollection).disposed(by: DisposeBag())
}

await main()
