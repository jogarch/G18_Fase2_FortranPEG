import Visitor from './Visitor.js';

export default class Tokenizador extends Visitor {
 
    visitProducciones(nodo) {
        return nodo.expr.accept(this);
    }
    visitOpciones(nodo){
        return nodo.exprs
            .map((expr) => expr.accept(this))
            .filter((str) => str)
            .join('\n');
    }
    visitUnion(nodo){
        return nodo.exprs
            .map((expr) => expr.accept(this))
            .filter((str) => str)
            .join('\n');
    }

    visitString(nodo){
        return `
        if ("${nodo.val}" == input(cursor:cursor + ${nodo.val.length - 1})) then
            allocate( character(len=${nodo.val.length}) :: lexeme)
            lexeme = input(cursor:cursor + ${nodo.val.length - 1})
            cursor = cursor + ${nodo.val.length}
            return
        end if
        `;
    }
}