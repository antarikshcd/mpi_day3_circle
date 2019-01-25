module mod_init
    use mod_global, only:mk, countchar

    ! initialize
    contains
        subroutine initialize(radius, side, n_total, n_circle, x_c, y_c, pi_tol, pi_diff, k, kmax, root)
            implicit none
            real(mk) :: pi_diff, pi_tol, radius, side, x_c, y_c, circle ! (x_c,y_c) center points of circle
            integer(mk) :: n_total, n_circle ! total points place within the square         
            integer :: k, kmax, root

            radius = 0.5 ! radius of the circle
            side = 1.0 ! length of side of square
            n_total = 10 ! total points seeding the monte-carlo
            n_circle = 0 ! initialize the counter for 
                         ! points that lie in the circle
            x_c = 0.5 ! centre of circle
            y_c = 0.5 ! centre of circle
            
            ! rank of process where the sum is reduced for getting n_in
            root = 0 
            ! initialize pi_diff to some large value
            pi_diff = 100.0
            ! initialize the iterations k-0
            k = 0
            kmax = 1000

            ! allocate the integer array msg
            !First, make sure the right number of inputs have been provided
            if(command_argument_count().ne.1) then
                write(*,*)'ERROR, ONE COMMAND-LINE ARGUMENT REQUIRED: ENTER TOLERANCE FOR PI, STOPPING'
                stop
            endif

            call get_command_argument(1,countchar)   !first, read in the two values

            ! convert it into integer of type double
            READ(countchar,*)pi_tol

        end subroutine initialize
end module mod_init