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

## Iterating
```swift
for x in iterate(initialValue: 1, transform: { $0 * 2 }) {
  print(x) // -> 1 -> 2 -> 4 -> 8 -> 16 -> 32 -> 64 -> 128 -> 256 -> ...
}
```

## Pairwise Comparing
```swift
for x in [1, 2, 3].pairwiseComparison() {
  print(x) // -> .Initial(1) -> .Pair(1, 2) -> .Pair(2, 3) -> .Final(3)
}
```

## Partitioning
```swift
for x in "hello world    how are you?".characters.partition({ ($0 == " ") != ($1 == " ") }).map(String.init) {
  print(x) // -> "hello" -> " " -> "world" -> "    " -> "how" -> " " -> "are" -> " " -> "you?"
}
```

## Unwrapping
```swift
for x in ["1.2", "4.6", "blah", "2.9"].map({ Float($0) }).unwrap() {
    print(x) // -> 1.2 -> 4.6 -> 2.9
}
```
