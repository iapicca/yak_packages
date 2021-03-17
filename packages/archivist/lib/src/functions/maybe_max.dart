/// returns the bigger num or null
T? maybeMax<T extends num>(T? a, T? b) => a == null
    ? b == null
        ? null
        : b
    : b == null
        ? a
        : a > b
            ? a
            : b;
