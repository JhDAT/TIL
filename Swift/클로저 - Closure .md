# 클로저 - Closure

- Function은 이름이 있는 closure입니다.
- 함수와는 다르게 이름 정의는 필요하지 않지만, 매개변수와 변환 값이 존재하는게 동일합니다.

<br>

<br>

## 문법

```swift
{(매개변수 목록) -> 반환타입 in
    실행코드
}
```

<br>

<br>

## 기본적인 사용

```swift
let sum: (Int, Int) -> Int = { (a:Int, b:Int) in
    return a + b
}

let sumResult: Int = sum(1, 2)
print(sumResult)					// 3
```

<br>

<br>

## 함수의 전달인자로서의 Closure

- 클로저는 함수의 전달인자로 사용이 가능합니다.
- 함수 내부에서는 원하느 코드 블럭은 실행 할 수 있습니다.

```swift
et add: (Int, Int) -> Int
add = { (a: Int, b: Int) in
    return a + b
}

let substract: (Int, Int) -> Int
substract = { (a: Int, b: Int) in
    return a - b
}

let divide: (Int, Int) -> Int
divide = { (a: Int, b: Int) in
    return a / b
}

func calculate(a: Int, b: Int, method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var calculated: Int

calculated = calculate(a: 50, b: 10, method: add)

print(calculated) // 60

calculated = calculate(a: 50, b: 10, method: substract)

print(calculated) // 40

calculated = calculate(a: 50, b: 10, method: divide)

print(calculated) // 5

calculated = calculate(a: 50, b: 10, method: { (left: Int, right: Int) -> Int in
    return left * right
})

print(calculated) // 500
```

