export default class VisitorFiltroNodos {
    constructor() {
        this.resultado = [];
    }

    visitProducciones(nodo) {
        // Recorrer hijos
        nodo.expr.accept(this);
        return this.resultado;
    }

    visitOpciones(nodo) {
        // Recorrer todos los hijos de exprs
        nodo.exprs.forEach(expr => expr.accept(this));
    }

    visitUnion(nodo) {
        // Agregar al resultado y recorrer hijos
        this.resultado.push(nodo);
        nodo.exprs.forEach(expr => expr.accept(this));
    }

    visitExpresion(nodo) {
        // Recorrer la expresión dentro del nodo
        if (nodo.expr) {
            nodo.expr.accept(this);
        }
    }

    visitString(nodo) {
        // Agregar al resultado
        this.resultado.push(nodo);
    }

    visitClase(nodo) {
        // Recorrer todos los caracteres en la clase
        nodo.chars.forEach(char => char.accept(this));
    }

    visitRango(nodo) {
        // Agregar al resultado
        this.resultado.push(nodo);
    }

    visitIdentificador(nodo) {
        // No es relevante para este filtro
    }

    visitPunto(nodo) {
        // No es relevante para este filtro
    }

    visitFin(nodo) {
        // No es relevante para este filtro
    }
}
