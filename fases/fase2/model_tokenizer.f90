module tokenizer
  implicit none
  private
  public :: nextSym

contains

  function nextSym(inputLine, position) result(token)
    ! Parámetros de entrada y salida
    character(len=*), intent(in) :: inputLine   ! Línea de entrada
    integer, intent(inout) :: position          ! Posición actual en la línea
    character(len=32) :: token                  ! Token reconocido o error léxico

    ! Variables locales
    character(len=1) :: currentChar
    integer :: startPos
    logical :: isRecognized

    token = ""             
    isRecognized = .false. 

    if (position > len_trim(inputLine)) then
      token = "<EOF>"
      return
    end if

    currentChar = inputLine(position:position)
    startPos = position

    if (currentChar== ' '   ) then  !.or. char(9) \t   char(10) \n  char(13) \r
      token = '" "'
      position= position+1
      isRecognized = .true.

! aqui hay que generar codigo por cada token valido 

    !ejemplo:  Integer "integer"
    !          = [0-9]+

    else if (currentChar >= '0' .and. currentChar <= '9') then
      do while (position <= len_trim(inputLine) .and. &
                inputLine(position:position) >= '0' .and. inputLine(position:position) <= '9')
        position = position + 1
      end do
      token = inputLine(startPos:position-1)
      isRecognized = .true.

! reconocer una regla literal .- case sensitive
    
    
! hasta aqui 
    end if

! errores lexicos 
    if (.not. isRecognized) then
      token = "Error lexico: -> " // trim(currentChar)
      position = position + 1
    end if

  end function nextSym

end module tokenizer