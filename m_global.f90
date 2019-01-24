module mod_global
    implicit none
	integer, parameter :: mkd = kind(1.0D0)
	integer, parameter :: mks = kind(1.0E0)
	integer, parameter :: mk = mkd
    real(mk), dimension(:), allocatable :: square_x, square_y
    integer, dimension(:), allocatable :: seed
    real(mk) :: radius, side, x_c, y_c, circle ! (x_c,y_c) center points of circle
    real(mk) :: pi, dist_sq
    integer(mk) :: n_total, n_circle, n_end, n_in ! total points place within the square
    integer :: i, info, seedsize, root, info
!    integer :: rank
    integer(mk) :: rank, size, ilen, ierror
    real(mk) :: t1, t2, delta_t, wall_time
    character(len=256) :: name
    !integer(mk) :: MPI_DOUBLE_PRECISION

end module mod_global