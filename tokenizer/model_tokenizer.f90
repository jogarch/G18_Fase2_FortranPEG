module parser
    implicit none

contains

    ! Subrutina principal que analiza la entrada
    subroutine parse(input)
        character(len=:), intent(inout), allocatable :: input
        character(len=32) :: lexeme
        integer :: cursor
        input = trim(input)
        cursor = 1
        do while (lexeme /= "EOF" .and. lexeme /= "ERROR")
            lexeme = nextSym(input, cursor)
            print *, lexeme
        end do
    end subroutine parse

    ! Función que obtiene el siguiente símbolo (lexema)
    function nextSym(input, cursor) result(lexeme)
        character(len=*), intent(in) :: input
        integer, intent(inout) :: cursor
        character(len=:), allocatable :: lexeme
        character(len=1) :: currentChar
        logical :: isRecognized

        ! Inicializa lexema
        allocate( character(len=32) :: lexeme )
        lexeme = ""
        isRecognized = .false.
        
        ! Si ya llegamos al final del input, devolvemos "EOF"
        if (cursor > len(input)) then
            lexeme = "EOF"
            return
        end if

        ! Lee el siguiente carácter
        currentChar = input(cursor:cursor)

        ! Ignorar espacios y saltos de línea
        do while (currentChar == " " .or. currentChar == "TAB" .or. &
            currentChar == CHAR(10) .or. currentChar == CHAR(13) )
            !print *, "Llego aqui"
            cursor = cursor + 1
            if (cursor > len(input)) then
                lexeme = "EOF"
                return
            end if
            currentChar = input(cursor:cursor)
        end do

        ! Verifica si el lexema es un número (por ejemplo, [0]?[1-9])
        call checkNumber(input, cursor, lexeme, isRecognized)

        ! Verifica si es un identificador (por ejemplo, [a-j]i)
        if (.not. isRecognized) then
            call checkIdentifier(input, cursor, lexeme, isRecognized)
        end if

        ! Verifica si es una palabra literal (por ejemplo, "atacar", "mover")
        if (.not. isRecognized) then
            call checkLiteral(input, cursor, lexeme, isRecognized)
        end if

        ! Verifica si el lexema es una palabra clave
        if (.not. isRecognized) then
            call checkKeyword(lexeme, isRecognized)
        end if

        ! Verifica si el lexema es un símbolo especial
        if (.not. isRecognized) then
            call checkSymbol(input, cursor, lexeme, isRecognized)
        end if

        ! Si no se reconoce, reporta un error
        if (.not. isRecognized) then
            print *, "Error lexico en col ", cursor, ', Char: ' // trim(currentChar)
            lexeme = "ERROR"
            cursor = cursor + 1
        end if

    end function nextSym

    ! Función que verifica si es un número
    subroutine checkNumber(input, cursor, lexeme, isRecognized)
        character(len=*), intent(in) :: input
        integer, intent(inout) :: cursor
        character(len=:), allocatable :: lexeme
        logical, intent(out) :: isRecognized
        character(len=1) :: currentChar
        character(len=32) :: number

        ! Lee el primer carácter
        currentChar = input(cursor:cursor)
        
        ! Verifica el caso de números
        if (currentChar >= '0' .and. currentChar <= '9') then
            number = ""
            ! Extrae el número completo
            do while (cursor <= len(input) .and. (input(cursor:cursor) >= '0' .and. input(cursor:cursor) <= '9'))
                number = trim(adjustl(number)) // input(cursor:cursor)
                cursor = cursor + 1
            end do
            lexeme = number
            isRecognized = .true.
        end if
    end subroutine checkNumber

    ! Función que verifica si es un identificador
    subroutine checkIdentifier(input, cursor, lexeme, isRecognized)
        character(len=*), intent(in) :: input
        integer, intent(inout) :: cursor
        character(len=:), allocatable :: lexeme
        logical, intent(out) :: isRecognized
        character(len=1) :: currentChar
        character(len=32) :: identifier

        ! Lee el primer carácter
        currentChar = input(cursor:cursor)

        ! Verifica si es una letra (a-z, A-Z)
        if ((currentChar >= 'a' .and. currentChar <= 'z') .or. (currentChar >= 'A' .and. currentChar <= 'Z')) then
            identifier = ""
            ! Extrae el identificador completo
            do while (cursor <= len(input) .and. ((input(cursor:cursor) >= 'a' .and. input(cursor:cursor) <= 'z') .or. &
                    (input(cursor:cursor) >= 'A' .and. input(cursor:cursor) <= 'Z')))
                identifier = trim(adjustl(identifier)) // input(cursor:cursor)
                cursor = cursor + 1
            end do
            lexeme = identifier
            isRecognized = .true.
        end if
    end subroutine checkIdentifier

    ! Función que verifica si es una palabra literal
    subroutine checkLiteral(input, cursor, lexeme, isRecognized)
        character(len=*), intent(in) :: input
        integer, intent(inout) :: cursor
        character(len=:), allocatable :: lexeme
        logical, intent(out) :: isRecognized
        character(len=1) :: currentChar
        character(len=32) :: literal

        ! Verifica si es una palabra literal (delimitada por comillas)
        if (input(cursor:cursor) == '"') then
            literal = ""
            cursor = cursor + 1
            do while (cursor <= len(input) .and. input(cursor:cursor) /= '"')
                literal = trim(adjustl(literal)) // input(cursor:cursor)
                cursor = cursor + 1
            end do
            ! Si encuentra el cierre de las comillas
            if (cursor <= len(input) .and. input(cursor:cursor) == '"') then
                lexeme = literal
                isRecognized = .true.
                cursor = cursor + 1  ! Avanza después de las comillas
            end if
        end if
    end subroutine checkLiteral

    ! Función que verifica si el lexema es una palabra clave
    subroutine checkKeyword(lexeme, isRecognized)
        character(len=*), intent(in) :: lexeme
        logical, intent(out) :: isRecognized
        character(len=32) :: keywords(2)
        
        ! Definir las palabras clave
        keywords(1) = "atacar"
        keywords(2) = "mover"
        
        ! Comparar el lexema con las palabras clave
        if (any(lexeme == keywords)) then
            isRecognized = .true.
        end if
    end subroutine checkKeyword

    ! Función que verifica si el lexema es un símbolo especial
    subroutine checkSymbol(input, cursor, lexeme, isRecognized)
        character(len=*), intent(in) :: input
        integer, intent(inout) :: cursor
        character(len=:), allocatable :: lexeme
        logical, intent(out) :: isRecognized
        character(len=1) :: currentChar

        ! Lee el siguiente carácter
        currentChar = input(cursor:cursor)

        ! Verifica si es uno de los símbolos especiales
        select case (currentChar)
        case (":")
            lexeme = ":"
            isRecognized = .true.
            cursor = cursor + 1

        case ("-")
            lexeme = "-"
            isRecognized = .true.
            cursor = cursor + 1
        case ("*")
            lexeme = "*"
            isRecognized = .true.
            cursor = cursor + 1
        case ("=")
            lexeme = "="
            isRecognized = .true.
            cursor = cursor + 1
        case default
            isRecognized = .false.
        end select
    end subroutine checkSymbol

end module parser
