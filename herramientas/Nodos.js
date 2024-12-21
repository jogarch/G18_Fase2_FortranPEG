const nodos = {
    Producciones: ['id', 'expr', 'alias'],
    Opciones: ['exprs'],
    Union: ['exprs'],
    Expresion: ['expr', 'label', 'qty'],
    Etiqueta:['ids','prefix', 'varios'],
    String: ['val', 'isCase'],
    Clase: ['chars', 'isCase'],
    Rango: ['inicio', 'fin'],
    Identificador : ['id'],
    Punto: [],
    Fin:[]
};

export default nodos;