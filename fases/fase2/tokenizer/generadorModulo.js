import Tokenizer from './Tokenizador.js';

export async function generateTokenizer(grammar) {
    const tokenizer = new Tokenizer();
    //console.log("dentro de generar modulo")
    //console.log(grammar.map((produccion) => produccion.accept(tokenizer)))
    return `
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

    ${grammar.map((Producciones) => Producciones.accept(tokenizer)).join('\n')}

    
! Manejar errores léxicos
    if (.not. isRecognized) then
      print *, "error lexico en col ", position, ', "'// trim(currentChar)//'" '
      token = "ERROR" 
      position = position + 1
    end if

  end function nextSym

  logical function isLetter(char)
    character(len=1), intent(in) :: char
    isLetter = (char >= 'A' .and. char <= 'Z') .or. (char >= 'a' .and. char <= 'z') .or. char == '_'
  end function isLetter

  logical function isDigit(char)
    character(len=1), intent(in) :: char
    isDigit = (char >= '0' .and. char <= '9')
  end function isDigit

end module tokenizer 
    `;
}