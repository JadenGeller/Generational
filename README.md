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
for x in zip([1, 2, 3], [5, 6], extendingWithDefaultValues: (0, 0)) {
  print(x) // -> (1, 5) -> (2, 6) -> (3, 0)
}
```
