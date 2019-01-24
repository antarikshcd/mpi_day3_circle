module mod_init
    use mod_global, only:mk

    ! initialize
    contains
        subroutine initialize(radius, side, n_total, n_circle, x_c, y_c)
            implicit none
            real(mk) :: radius, side, x_c, y_c, circle ! (x_c,y_c) center points of circle
            integer(mk) :: n_total, n_circle ! total points place within the square         

            radius = 0.5 ! radius of the circle
            side = 1.0 ! length of side of square
            n_total = 10**8 ! total points seeding the monte-carlo
            n_circle = 0 ! initialize the counter for 
                         ! points that lie in the circle
            x_c = 0.5 ! centre of circle
            y_c = 0.5 ! centre of circle
        end subroutine initialize
end module mod_init