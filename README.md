# alidiep-swift-booking
This is app for booking ticket.

Structure: VIPER

API: https://meteor-experienced-sneezeweed.glitch.me

## VIPER
![image](https://user-images.githubusercontent.com/1216114/133011810-c18f6913-90cf-4b07-b1d4-e8989e91bfa4.png)

### View Controller
- SnapKit is using to layout view.

#### How to layout seats
- Seats are layout in matrix NxM (N rows, M cols).
Example:
```
0 0 0 3 3 3 3 0 0 0
0 -1 0 0 0 0 0 0 -1 0
0 0 1 1 1 1 1 1 0 0
0 0 1 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0 0 0
```
For detail of matrix, read document of API [here](https://github.com/alidiepuit/alidiep-server-booking).

- (X,Y) is position of seat in matrix (col X, row Y).
- Width of container seats is W.
- Width of each seat equal alpha (here I define width = height):
```
alpha = W / M
```
- So position of seat in view is (x,y) (x left, y top):
```
x = alpha * X
y = alpha * Y
```

#### Valid information of user
- Using ReactiveSwift
```
self.valid = Property.combineLatest(self.name, self.email).map { (name, email) in
    return name.count > 0 && email.count > 0 && self.isValidEmail(email)
}
```
Just enable button booking when user input valid information.

## Manager Booking

```
let client = APIClient()
let manager = BookingManager(api: client)
```

- APIClient use Alamofire 5.4.3

- BookingManager inject this client to call API.

- I use Codable protocol to Decode and Encode data from server or vice versa.

Example:
```
struct SeatEntity: Codable {
    var type: SeatType
    var enable: Bool
    var position: SeatPosition
    var price: Float
}

enum SeatType: Int, Codable {
    case standard = 0
    case vip = 1
    case recliner = 2
    case wheel = 3
    case notBookable = 4
    case occupied = 5
}

struct SeatPosition: Codable, Equatable {
    var x: Int
    var y: Int
}
```
