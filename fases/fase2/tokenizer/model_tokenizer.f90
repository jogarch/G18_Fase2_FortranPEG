module tokenizer
  implicit none
  private
  public :: nextSym

contains

  function nextSym(inputLine, position) result(lexema)
    ! Parámetros de entrada y salida
    character(len=*), intent(in) :: inputLine   ! Línea de entrada
    integer, intent(inout) :: position          ! Posición actual en la línea
    character(len=32) :: lexema                  ! lexema reconocido o error léxico

    ! Variables locales
    character(len=1) :: currentChar
    integer :: startPos
    logical :: isRecognized

    lexema = ""             
    isRecognized = .false. 

    do while (position <= len_trim(inputLine) .and. &
          (inputLine(position:position) == ' ' .or. &
           inputLine(position:position) == char(9) .or. &  ! Tabulador
           inputLine(position:position) == char(10) .or. & ! Salto de línea
           inputLine(position:position) == char(13)))     ! Retorno de carro
          position = position + 1
    end do

    if (position > len_trim(inputLine)) then
      lexema = "EOF"
      return
    end if

    currentChar = inputLine(position:position)
    startPos = position

! aqui hay que generar codigo por cada lexema valido 

    !ejemplo:  Integer "integer"
    !          = [0-9]+

    if (currentChar >= '0' .and. currentChar <= '9') then
      do while (position <= len_trim(inputLine) .and. &
                inputLine(position:position) >= '0' .and. inputLine(position:position) <= '9')
        position = position + 1
      end do
      lexema = inputLine(startPos:position-1)
      isRecognized = .true.

! reconocer una regla literal .- case sensitive
    
    
! hasta aqui 
    end if

! errores lexicos 
    if (.not. isRecognized) then
      print *, "error lexico en col ", position, ', "'// trim(currentChar)//'" '
      token = "ERROR" 
      position = position + 1
    end if

  end function nextSym



end module tokenizer