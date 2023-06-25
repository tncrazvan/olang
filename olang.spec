u8 := 0..9 | 0..9 u8

curly_l := {
curly_r := }
round_l := (
round_r := )
square_l := [
square_r := ]
angle_l := <
angle_r := >
boolean := true | false
try := try

block := $curly_l {?} $curly_r

group := $round_l {?} $round_r

name := A..z A..9_ | $name
macro_name := @ $name

property_separator := .

$or = or

$and = and

$not = not

property := $property_separator $name | $property_separator $property

boolean_member := $boolean $or $boolean | $boolean $and $boolean | $boolean | $round_l $boolean_member $round_r

constant := const $name : $name = | const $macro_name = comptime $block
variable := var $name : $name =

parameters := $name : $name | $parameters , | $parameters
arguments := $name = $expression | $arguments , | $arguments

function := fn $round_l $parameters $round_r $name $block

public_function := pub $function

call := $name $group | $macro_name $group

addition_member := $u8 | $call
subtraction_member := $u8 | $call
division_member := $u8 | $call
multiplication_member := $u8 | $call

addition := $addition_member + $addition_member
subtraction := $subtraction_member - $subtraction_member
division := $division_member / $division_member
subtraction := $subtraction_member * $subtraction_member
multiplication := $multiplication_member * $multiplication_member

expression = $call | $name | $addition | $subtraction | $division | $multiplication | $u8 | $boolean_member

structure := struct $block

comptime := comptime
