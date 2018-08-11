# 클로저 - Closure - 더 알아보기

<br>

## Capture List

- 주변의 범위에서 참조한 변수들을 얼마나 강하게 캡쳐해야 하는지를 명시하는것입니다.

```swift
var a = 1
var b = 2
var c = 10
var result = 0
print("초기화 값 :", a, b, c, result)		// 1, 2, 10, 0

let valueCapture = { [a, b] in
 result = a + b + c							// 8
 print("클로저 내부 값 :", a, b, c, result)	// 1, 2, 5, 8 
}

a = 10
b = 10
c = 5
result = a + b + c		// 25
print("변경 값 :", a, b, c, result)	// 10, 10, 5, 25

valueCapture()
print("실행 이후 값 :", a, b, c, result)	// 10, 10, 5, 8
```

1. `print("초기화 값 :", a, b, c, result)` 의 결과는 1, 2, 10, 0 입니다.
2. a와 b의 값인 1, 2가 capture가 되었습니다.
3. a, b, c, result를 10, 10, 5, 25로 값을 변경해 주었습니다.
4. print("변경 값 :", a, b, c, result) 의 결과는 10, 10, 5, 25입니다.
5. valueCapture()를 사용해서 closure를 실행합니다.
   1. 내부에서는 capture해 놓은 a = 1, b = 2를 사용합니다.
   2. result의 값은 8됩니다.
   3. print("클로저 내부 값 :", a, b, c, result) 의 결과는 1, 2, 5, 8입니다.
6. print("실행 이후 값 :", a, b, c, result) 는 변경된 값을 사용하기 때문에 10, 10, 5, 8입니다.

<br>

<br>

## @noescaping 

- 해당 범위내에서만 동작하게 하고 범위 밖에서는 사용하지 못하게 하는 키워드를 말합니다.
- Swift 3.0 이후 부터는 기본값으로 들어가게 됩니다.

```swift
class someClass {
    var closure: (() -> ())?
    func noEscapingClosure(_ arg: () -> ()) {
        self.closure = arg // required @escaping
    }
}
```

- self.closure에 클로저 타입은 arg를 대입하면 에러가 발생합니다.
- 이유는 arg는 noescamping으로 동작하기 때문에 해당 함수 범위 내에서만 사용하도록 되어 있습니다. (즉, 범위 밖에서는 사용하지 못하도록 제한이 됩니다.)

<br>

<br>

## @escaping

- 클로저 파라미터를 함수 범위 밖에서 사용하고 싶을때 사용하는 키워드 입니다.
- Swift 3.0 이전까지는 기본값입니다. (사용하기 위해서는 @escaping을 명시해 줘야 합니다.)

```swift
class someClass {
    var closure: (() -> ())?
    func noEscapingClosure(_ arg: @escaping () -> ()) {
        self.closure = arg
    }
}
```

<br>

<br>

## 값 전달

- @noescaping -> @noescaping 가능
- @noescaping -> @escaping   불가능
- @escaping   -> @noescaping, @escaping 둘 다 가능
- noescaping은 내부에서만 사용하기 때문에  escaping된 것을 받아와서 사용할수는 있지만 반대로는 사용할수 없습니다.

<br>

<br>

## @autoclosure

- 파라미터가 없는 표현식을 클로저로 변환하는 키워드입니다. 
- 파라미터가 없는 표현식이라는 건 `()->(), ()->Int`, `() -> ()` 입니다.
- @autoclosure 키워드를 사용하면 파라미터로 클로저를 받을 수 있습니다.

```swift
var value2 = 10
func autoclosure(_ arg1: String, _ arg2: @autoclosure () -> ()) {
    print(arg1)
    arg2()
}

autoclosure("arg1", print("Autoclosure"))	// arg1, Autoclosure

autoclosure("arg1", value2 += 10)			// arg1
```

<br>

- Autoclosure 파라미터에 일반 클로저 형태는 사용 불가 

```swift
autoclosure("arg1") {
    print("Compile Error")
}
```