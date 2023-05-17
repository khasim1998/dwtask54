%dw 2.0
output application/csv
import * from dw::core::Arrays
/*
1) variable 'keys' will store all the columns for csv
2) variable 'countColumn' will store count of all column
3) variable 'values' will store values of 'Header part' plus (keys and values 
of 'Data part') plus (keys and values of 'Footer part')
4) script logic will return the expected output in csv 
*/

var keys= keysOf(payload.Header)
var countColumn= sizeOf(keysOf(payload.Header))
var values = valuesOf(payload.Header) ++ keysOf(payload.Data[0]) ++ flatten(payload.Data map ((item, index) -> valuesOf(item) )) ++ keysOf(payload.Footer)
++ valuesOf(payload.Footer)
---
(values divideBy  countColumn) map ((item, index) -> item map ((item1, index1) -> 
(keys[index1]): item1 )reduce ((item, accumulator={}) -> accumulator ++ item ))