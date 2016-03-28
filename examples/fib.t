letrec fib=(x ->
  if x < 1 then 0
  else if x < 2 then 1
  else (fib $ (x - 2))+(fib $(x-1))
) in
println_int $ (fib $ 10)
