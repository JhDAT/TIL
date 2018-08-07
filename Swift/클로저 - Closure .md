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

<br>

<br>

## 클로저의 다양한 표현

- 다양한 방법을 사용해서 축약할 수 있습니다. 그러나 너무 축약된 코드는 시간이 지난 뒤에 볼때 명시성이 떨어질 수 있으므로 적정선에서 축약해야 합니다.

### 1. 후행 클로저 - trailing closure

- 함수의 매개변수의 마지막으로 전달되는 클로저는 trailing closure(후행 클로져)로 함수 밖에 구현할 수 있습니다.
- 클로저가 함수의 마지막 전달인자일때는 마지막 매개변수 이름을 생략한 후 함수 소괄호 외부에 클로져를 구현할 수 있습니다.

```swift
result = calculate(a: 10, b: 10) { (left: Int, right: Int) -> Int in
    return left + right
}

print(result) // 20
```

<br>

<br>

### 2. 반환타입 생략

- 컴파일러가 클로저의 타입을 유추할 수 있는 경우 매개변수, 반환 타입을 생략할 수 있습니다.

- `calculate(a:b:)method:)` 의 함수의 method 매개변수는 Int 타입을 반환할 것이라는 사실을 컴파일러도 알기 때문에 반환 타입을 명시해 주지 않아도 됩니다. 대신 in 키워드는 생략할 수 없습니다.

```swift
result = calculate(a: 10, b: 10, method: { (left: Int, right: Int) in
    return left + right
})

print(result) // 20
```

<br>

<br>

### 3. 후행 클로저 + 반환타입 생략

```swift
result = calculate(a: 10, b: 10) { (left: Int, right: Int) in
    return left + right
}

print(result) // 20
```

<br>

<br>

### 4. 단축 인자이름

- 전달인자의 이름이 굳이 필요없고, 컴파일러가 타입을 유추할 수 있는경우에는 단축 인자 이름을 사용할 수 있습니다.

- 단축 인자의 이름은 클로저의 매개변수의 순서대로 `$0, $1, $2` 와 같이 표현합니다.

```swift
result = calculate(a: 10, b: 10, method: {
    return $0 + $1
})
print(result) // 20

// 후행 클로저
result = calculate(a: 10, b: 10) {
    return $0 + $1
}
print(result) // 20
```

<br>

<br>

### 5. 암시적 반환 표현

- 클로저가 반환하는 값이 있다면 암시적으로 클로저의 맨 마지막 줄은`return` 키워드를 생략해도 암시적으로 반환값으로 취급합니다.

```swift
result = calculate(a: 10, b: 10) {
    $0 + $1
}
print(result) // 20

result = calculate(a: 10, b: 10) { $0 + $1 }
print(result) // 20
```

<br>

<br>

