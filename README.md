# Duxer

Heavily influenced by [ReSwift](https://github.com/ReSwift/ReSwift) & [SwiftRex](https://github.com/SwiftRex/SwiftRex)

## Example

To run the example project, clone the repo, and run `pod install` from the **Example** directory first.

Declare **Actions**:
```swift
enum UserAction: DXAction {
    case register(UserData)
    case logout(UserData)
}
```
**State**:
```swift
struct AppState: State {
    var user: UserState = .init()
    var card: CardState = .init()
    var transaction: TransactionState = .init()
}

struct UserState: State {
    ...
}

struct CardState: State {
    ...
}

struct TransactionState: State {
    ...
}
```
**Reducer**(**s**):
```swift

let rootReducer: DXReducer<AppState> = { state, action in
    AppState(
        user: userReducer(state.user, action),
        card: cardReducer(state.card, action),
        transaction: transactionReducer(state.transaction, action)
    )
}

let userReducer: DXReducer<UserState> = { state, action in
    ...
}

let cardReducer: DXReducer<CardState> = { state, action in
    ...
}

let transactionReducer: DXReducer<TransactionState> = { state, action in
    ...
}
```
Use **MiddleWares** to capture/modify actions **before** they reach the **reducer**:
```swift
let loggerMiddleware: DXMiddleware<AppState> = { dispatch, state, action in
    defer { debugPrint(":LOGGER:", Date(), String(describing: action)) }

    return action
}
```
Utilize **Thunks** for producing **side-effects**:
```swift
func networkActionThunk(data: RequestData) -> DXThunk<AppState> {
    .init { dispatch, state in
        NetworkService.fetchData(data: data) { result in
            switch result {
            case let .success(responseData):
                dispatch(NetworkAction.success(responseData))

            case let .failure(error):
                dispatch(NetworkAction.failure(error))
            }
        }
    }
}
```
**Dispatch** thunks just like any other **action**:
```swift
@objc
func buttonTouchUpInside() {
    self.store.dispatch(TransferAction.pendingTransferFormUpdate(self.transferForm))

    guard let requestData,
          let requestData.isValid
    else { return }

    self.store.dispatch(networkActionThunk(data: requestData)
}
```
Convenient state projection to discard non-required state updates:
```swift
self.store.projection { (state: AppState) in
    state.card // CardState
}
.sink { (state: CardState) in
    // We will only receive unique updates on CardState instead of the main AppState.
    print(":LOG:", Self.self, "state = \(state)")
}
.store(in: &self.cancellables)
```
Or you can use provided `DXViewController` / `DXViewModel`, and call `setupStateSubscription`:
```swift
class UserViewController: DXVC<UserState> {

    let store: DXStore<AppState> = Store.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupStateSubscription(store: self.store, projector: { $0.user })
    }
}
```


## Installation

Duxer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Duxer'
```

## Author

Kenan Alizadeh, kananalizade@gmail.com

## License

Duxer is available under the MIT license. See the LICENSE file for more info.
