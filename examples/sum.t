letrec sum=(λ xs ->
        match(xs,
          []->0,
          [x|xs]->x+(sum $ xs)))
in
println_int $ (sum $ [1,2,3,4,5])

