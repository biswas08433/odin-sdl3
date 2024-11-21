package main

import sdl "sdl3"

main :: proc(){
    sdl.Init(sdl.INIT_VIDEO)
    window := sdl.CreateWindow("Hello World!",  100, 100, sdl.WINDOW_OPENGL)
    if window == nil {
        panic("Could not create window")
    }

    gpu := sdl.CreateGPUDevice()


    sdl.DestroyWindow(window)
    sdl.Quit()
}
