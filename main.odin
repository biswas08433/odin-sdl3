package main

import sdl "sdl3"

main :: proc(){
    sdl.Init(sdl.INIT_VIDEO)
    window := sdl.CreateWindow("Hello World!",  640, 480, sdl.WINDOW_OPENGL)
    if window == nil {
        panic("Could not create window")
    }
    sdl.Delay(3000)
    sdl.Quit()
}
