letrec nth=(s -> n -> 
  match(s
    | []->""
  	| x::xs->if n < 1 then x else nth $ xs $ (n-1)
  )
) in
let s = nth $ argv $ 1 in
let n = nth $ argv $ 2 in
let e = nth $ argv $ 3 in
let m = nth $ argv $ 4 in
letrec insert=(s -> n -> v ->
  if n<2 then v::s else
    match(s
    | [] -> v::s
    | x::xs -> x::insert $ xs $ (n-1) $ v
    )
) in
letrec remove=(s -> n ->
  match(s
  | [] -> []
  | x::xs -> 
    if n<2 then xs else x::remove $ xs $ (n-1)
  )
) in
let e = match(e | []->0 | x::xs->x) in
println_string $ (remove $ (insert $ s $ (int_of_string $ n) $ e) $ 3)
