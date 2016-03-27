match(argv, []->println_string $ "input error",
  [x|y]->
    match(y, []->println_string $ "input error",
      [w|z]->
        match(z, []->println_string $ "input error",
          [h|zz]->
            letrec write_sharp = (λ w ->
              if(w < 1, println_string $ "",
                let t=print_string $ "#" in
                write_sharp $ (w - 1)))
            in
            letrec write_sharp_line = (λ h -> (λ w ->
              if(h < 1, "",
                let t= write_sharp $ w in
                write_sharp_line $ (h - 1) $ w)))
            in
            write_sharp_line $ (int_of_string $ h) $ (int_of_string $ w)
            
        )
    )
)