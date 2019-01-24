module mod_global
    implicit none
	integer, parameter :: mkd = kind(1.0D0)
	integer, parameter :: mks = kind(1.0E0)
	integer, parameter :: mk = mkd
    real(mk), dimension(:), allocatable :: square_x, square_y
    integer, dimension(:), allocatable :: seed
    real(mk) :: radius, side, x_c, y_c, circle ! (x_c,y_c) center points of circle
    real(mk) :: pi, dist_sq
    integer(mk) :: n_total, n_circle ! total points place within the square
    integer :: i, info, seedsize
    integer :: rank
end module mod_global