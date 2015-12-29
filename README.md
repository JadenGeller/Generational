# Generational

## Concatenation
```swift
for x in (1...3) + (7...9) {
  print(x) // -> 1 -> 2 -> 3 -> 7 -> 8 -> 9
}
```

## Cycling
```swift
for x in [1, 2, 3].cycle() {
  print(x) // -> 1 -> 2 -> 3 -> 1 -> 2 -> 3 -> 1 -> 2 -> 3 -> ...
}
```

## Extending
```swift
for x in [1, 2, 3].extend(byRepeatingValue: 0) {
  print(x) // -> 1 -> 2 -> 3 -> 0 -> 0 -> 0 -> ...
}
```

## Full Zipping
```swift
for x in fullZip([1, 2, 3], [5, 6]) {
  print(x) // -> (1, 5) -> (2, 6) -> (3, nil)
}

for x in fullZip([1, 2, 3], [5, 6], defaultValues: (9, 9)) {
  print(x) // -> (1, 5) -> (2, 6) -> (3, 9)
}
```

## Dropping
```swift
for x in (1...10).dropWhile({ $0 <= 3 || $0 => 7 }) {
  print(x) // -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 -> 10
}
```

## Taking
```swift
for x in (1...10).takeWhile({ $0 <= 3 || $0 => 7 }) {
  print(x) // -> 1 -> 2 -> 3
}
```
