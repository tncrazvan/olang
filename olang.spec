number := 0..9

curly_l := {
curly_r := }
round_l := (
round_r := )
square_l := [
square_r := ]
angle_l := <
angle_r := >
boolean := true | false

string := string $lsquare $number $rsquare

block := $curly_l {?} $curly_r

group := $round_l {?} $round_r

name := A..z A..9_ | $name

property_separator := .

property := $property_separator $name | $property_separator $property

boolean_member := $boolean or $boolean | $boolean and $boolean | $boolean | $round_l $boolean_member $round_r

constant := const $name =
variable := var $name =

parameters := $name : $name | $parameters , | $parameters
arguments := $name = $expression | $arguments , | $arguments

function := fn $round_l $parameters $round_r : $name $block

public_function := pub $function

call := $name $group

addition_member := $number | $call
subtraction_member := $number | $call
division_member := $number | $call
multiplication_member := $number | $call

addition := $addition_member + $addition_member
subtraction := $subtraction_member - $subtraction_member
division := $division_member / $division_member
subtraction := $subtraction_member * $subtraction_member
multiplication := $multiplication_member * $multiplication_member

expression = $call | $name | $addition | $subtraction | $division | $multiplication | $number | $string | $boolean_member

not := not $block | not $expression

structure := struct $block

comptime := comptime
