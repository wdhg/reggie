# reggie

Run and encode simple register machine programs. Inspired by the COMP50003 Models of Computation course at Imperial College London.

## Install

Clone this repository and run:

```
cd reggie
make
stack install
```

## Usage

To run a program:

```
reggie run my_program
```

To encode a program:

```
reggie encode my_program
```

## Example programs

For now the line number (excluding blank lines) equals the label number.

`examples/prog0` registers 0 and 1 to values of 3 and 4 respectively:

```
R0+ -> L1
R0+ -> L2
R0+ -> L3

R1+ -> L4
R1+ -> L5
R1+ -> L6
R1+ -> L7

HALT
```

This program encodes to 39492109375708945017428251152200252277644104767136612412758819336.

`examples/prog1` adds 3 and 4 and stores the result in R0:

```
R1+ -> L1
R1+ -> L2
R1+ -> L3

R2+ -> L4
R2+ -> L5
R2+ -> L6
R2+ -> L7

R1- -> L8, L9
R0+ -> L7
R0+ -> L10

R2- -> L11, L12
R0+ -> L10
R0+ -> L13

HALT
```

This program encodes to `examples/prog1.encode`, which is 1010111 digits long!

# To Do

- [ ] Erroneous halting
- [ ] Decoding programs
- [ ] Add support for custom initial register states
- [ ] More detailed parsing / lexical errors
- [ ] Functions / modules
- [ ] Custom labels
- [ ] Comments
