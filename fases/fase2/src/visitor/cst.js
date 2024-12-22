
// Auto-generated
import Nodo from './Nodo.js';

export class Producciones extends Nodo {
    constructor(id, expr, alias) {
        super();
        this.id = id;
		this.expr = expr;
		this.alias = alias;
    }

    accept(visitor) {
        return visitor.visitProducciones(this);
    }
}
    
export class Opciones extends Nodo {
    constructor(exprs) {
        super();
        this.exprs = exprs;
    }

    accept(visitor) {
        return visitor.visitOpciones(this);
    }
}
    
export class Union extends Nodo {
    constructor(exprs) {
        super();
        this.exprs = exprs;
    }

    accept(visitor) {
        return visitor.visitUnion(this);
    }
}
    
export class Expresion extends Nodo {
    constructor(expr, label, qty) {
        super();
        this.expr = expr;
		this.label = label;
		this.qty = qty;
    }

    accept(visitor) {
        return visitor.visitExpresion(this);
    }
}
    
export class String extends Nodo {
    constructor(val, isCase) {
        super();
        this.val = val;
		this.isCase = isCase;
    }

    accept(visitor) {
        return visitor.visitString(this);
    }
}
    
export class Clase extends Nodo {
    constructor(chars, isCase) {
        super();
        this.chars = chars;
		this.isCase = isCase;
    }

    accept(visitor) {
        return visitor.visitClase(this);
    }
}
    
export class Rango extends Nodo {
    constructor(bottom, top) {
        super();
        this.bottom = bottom;
		this.top = top;
    }

    accept(visitor) {
        return visitor.visitRango(this);
    }
}
    
export class Identificador extends Nodo {
    constructor(id) {
        super();
        this.id = id;
    }

    accept(visitor) {
        return visitor.visitIdentificador(this);
    }
}
    
export class Punto extends Nodo {
    constructor() {
        super();
        
    }

    accept(visitor) {
        return visitor.visitPunto(this);
    }
}
    
export class Fin extends Nodo {
    constructor() {
        super();
        
    }

    accept(visitor) {
        return visitor.visitFin(this);
    }
}
    