import { writeFileSync } from 'node:fs';
import path from 'node:path';
import nodos from './Nodos.js';

const __dirname = import.meta.dirname;
const classesDestination = '../src/visitor/CST.js';
const visitorDestination = '../src/visitor/Visitor.js';

let codeString = `
// Auto-generated
export default class Visitor {
`;
for (const nodo of Object.keys(nodos)) {
    codeString += `\tvisit${nodo}(nodo) {}\n`;
}
codeString += `}`;

writeFileSync(path.join(__dirname, visitorDestination), codeString);
console.log('Generated visitor Interface');

codeString = `
// Auto-generated
import Nodo from './Nodo.js';
`;
for (const [name, args] of Object.entries(nodos)) {
    codeString += `
export class ${name} extends Nodo {
    constructor(${args.join(', ')}) {
        super();
        ${args.map((arg) => `this.${arg} = ${arg};`).join('\n\t\t')}
    }

    accept(visitor) {
        return visitor.visit${name}(this);
    }
}
    `;
    console.log(`Generating ${name} nodo`);
}

writeFileSync(path.join(__dirname, classesDestination), codeString);