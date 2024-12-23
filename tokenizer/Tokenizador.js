import Visitor from '../src/visitor/Visitor.js';
//import {Rango} from '../visitor/cst.js';


export default class Tokenizador extends Visitor {
 
    visitProducciones(nodo) {
        //console.log("nodo producciones")
        //console.log(nodo.expr)
        return nodo.expr.accept(this);
    }
    visitOpciones(nodo){
        //console.log("en este nodo opciones")
        //console.log(nodo.exprs)
        return nodo.exprs
            .map((expr) => expr.accept(this))
            .filter((str) => str)
            .join('\n');
    }
    visitUnion(nodo){
        //console.log("nodo Union")
        //console.log(nodo.exprs)
        return nodo.exprs
            .map((expr) => expr.accept(this))
            //.filter((str) => str)
            //.join('\n');
    }

    visitString(nodo){
        //console.log("llega a este nodo")
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

