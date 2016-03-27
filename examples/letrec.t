letrec(sum=(λ x -> if(x < 1, x, x+(sum $ (x - 1)))) in (sum $ 10))
