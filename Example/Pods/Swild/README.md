# Swild
**Concise builder for Swift.**

## Example

```swift
import UIKit
import Swild

class ViewController: UIViewController {

    let myView: UIView = .build { v in
        v.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        v.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(myView)
    }
}
```

## Installation

Swild is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Swild'
```

## Author

Kenan Alizadeh, kananalizadeh@gmail.com

## License

Swild is available under the MIT license. See the LICENSE file for more info.
