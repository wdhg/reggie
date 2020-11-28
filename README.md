# reggie

Run and encode simple register machine programs. Inspired by the COMP50003 Models of Computation course at Imperial College London.

## Install

Installation is done using stack. Clone this repository and run:

```
cd reggie
make install
```

## Usage

To run a program:

```
reggie run my_program
reggie run my_program2 10 12
```

To encode a program:

```
reggie encode my_program
```

To decode a program:

```
reggie decode 39492109375708945017428251152200252277644104767136612412758819336
```

## Example programs

For now the line number (excluding blank lines) equals the label number.

`examples/prog0` registers 0 and 1 to values of 3 and 4 respectively:

```
L0: R0+ -> L1
L1: R0+ -> L2
L2: R0+ -> L3

L3: R1+ -> L4
L4: R1+ -> L5
L5: R1+ -> L6
L6: R1+ -> L7

L7: HALT
```

This program encodes to 39492109375708945017428251152200252277644104767136612412758819336.

`examples/prog1` adds 3 and 4 and stores the result in R0:

```
L0: R1+ -> L1
L1: R1+ -> L2
L2: R1+ -> L3

L3: R2+ -> L4
L4: R2+ -> L5
L5: R2+ -> L6
L6: R2+ -> L7

L7: R1- -> L8, L9
L8: R0+ -> L7
L9: R0+ -> L10

L10: R2- -> L11, L12
L11: R0+ -> L10
L12: R0+ -> L13

L13: HALT
```

This program encodes to `examples/prog1.encode`, which is 1010111 digits long!

`examples/add` takes two values from R1 and R2 and adds them to R0

```
# clear return register
L0: R0- -> L0, L1

# increment the sumands
L1: R1+ -> L2
L2: R2+ -> L3

# add R1 to R0
L3: R1- -> L4, L5
L4: R0+ -> L3

# add R2 to R0
L5: R2- -> L6, L7
L6: R0+ -> L5

# increment the output
L7: R0+ -> L8

L8: HALT
```

```
$ reggie run add 0 75 25
[(0,100),(1,0),(2,0)]
```

# To Do

- [x] Erroneous halting
- [x] Decoding programs
- [x] Add support for custom initial register states
- [ ] More detailed parsing / lexical errors
- [ ] Functions / modules (Gadgets)
- [ ] Custom labels
- [x] Comments
