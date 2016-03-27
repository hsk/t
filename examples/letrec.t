letrec sum=
  (λ x -> if(x < 1, x, x+(sum $ (x - 1))))
in
println_int $ (sum $ 10)
