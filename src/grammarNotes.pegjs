calculator
    = expr

expr 
    = head:factor rest:(addop factor)*
    { return rest.reduce (
        (result, [op, right]) => 
        {
            if(op == "-") {
                return result - right}
            else {
                return result + right
            }
        },
        head
      )
    }

factor
  = head:term rest:(mulop factor)*
    { return rest.reduce(
      (result, [op, right]) => 
        {
            if(op == "/") {
                return result / right}
            else {
                return result * right
            }
        },
        head
      )
    }

addop
    = "+"/"-"

mulop
    ="*"/"/"
  
term 
    = integer
    / _ "(" expr: expr ")" _
    { return expr }

integer
    = _ digits:"-"? [0-9]+ _
    { return parseInt(text(), 10); }

_ "whitespace"
    = [ \t\n\r]*
