letrec sum=(x ->
  if x < 1 then x else x+(sum $ (x - 1))
) in
println_int $ (sum $ 10)
