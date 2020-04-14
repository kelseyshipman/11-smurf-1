calculator
    = expr

expr 
    = head:factor rest:(addop factor)*
    { return rest.reduce (
        (result, [op, _, right]) => new AST.BinOp(result, op, right)
        head
        )
    }

factor
  = head:term rest:(mulop factor)*
    { return rest.reduce(
        (result, [op, _, right]) => new AST.BinOp(result, op, right)
        head
        )
    }

term 
    = integer
    / _ "(" expr: expr ")" _
    { return expr }

integer
    = _ digits:"-"? [0-9]+ _
    { return new AST.Integer(parseInt(digits.join(""), 10)) }

addop
    = "+"/"-"

mulop
    ="*"/"/"
    
_ "whitespace"
  = [ \t\n\r]*
