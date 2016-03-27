letrec(fib=(λ x ->
        if(x < 2, x, (fib $ (x - 2))+(fib $(x-1) )))
      in (fib $ 40)).
