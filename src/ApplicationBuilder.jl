module ApplicationBuilder

if get(ENV, "COMPILING_APPLE_BUNDLE", "false") == "true"
    function change_dir_if_bundle()
        full_binary_name = PROGRAM_FILE  # PROGRAM_FILE is set manually in program.c
        println("full_binary_name: $full_binary_name")
        if is_apple()
            # On Apple devices, if this is running inside a .app bundle, it starts
            # us with pwd="/". Change dir to the Resources dir instead.
            # Can find the code's path from what the full_binary_name ends in.
            m = match(r".app/Contents/MacOS/[^/]+$", full_binary_name)
            if m != nothing
                resources_dir = joinpath(dirname(dirname(full_binary_name)), "Resources")
                println("resources_dir: $resources_dir")
                cd(resources_dir)
            end
            println("change_dir_if_bundle(): Changed to new pwd: $(pwd())")
            return pwd()
        end
    end
else
    function change_dir_if_bundle()
        println("change_dir_if_bundle(): Did not change pwd: $(pwd())")
        return pwd()
    end
end

end # module