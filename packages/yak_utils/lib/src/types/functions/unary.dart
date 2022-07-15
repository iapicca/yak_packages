/// a typedef for a "unary" [Function]
typedef Unary<T, S> = T Function(S);
typedef UnaryAsync<T, S> = Unary<Future<T>, S>;