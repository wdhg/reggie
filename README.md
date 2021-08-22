# reggie

Run and encode simple register machine programs. Inspired by the COMP50003 Models of Computation course at Imperial College London.

## Install

To build `reggie` you need `alex` and `happy`. These can be installed by running: 

```
stack install alex happy
```

Installation of `reggie` is done using stack. Clone this repository and run:

```
cd reggie
make install
```

## Usage

To run a program:

```
reggie run my_program
reggie run my_program 10 12 # run with registers R0 = 10, R1 = 12
```

To run a program step-by-step:

```
reggie step my_program
reggie step my_program 10 12
```

To encode a program:

```
reggie encode my_program
```

To decode a program:

```
reggie decode 1356938545749799165120738728340994364585019113312996743434322372066314551816
```

To decode a program like 2<sup>94</sup> * 16395:

```
reggie decode2 94 16395
```

## Example programs

`examples/prog0` registers 0 and 1 to values of 3 and 4 respectively:

```
L0: R0+ -> L1
L1: R0+ -> L2
L2: R0+ -> L4

L4: R1+ -> L5
L5: R1+ -> L6
L6: R1+ -> L7
L7: R1+ -> L8
L8: HALT
```

This program encodes to 1356938545749799165120738728340994364585019113312996743434322372066314551816

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

L9: R2- -> L10, L11
L10: R0+ -> L9

L11: HALT
```

This program encodes to `examples/prog1.encode`, which is 1010111 digits long!

`examples/add` takes two values from R1 and R2 and adds them to R0

```
# clear return register
L0: R0- -> L0, L1

# add R1 to R0
L1: R1- -> L2, L3
L2: R0+ -> L1

# add R2 to R0
L3: R2- -> L4, L5
L4: R0+ -> L3

# increment the output
L5: R0+ -> L6

L6: HALT
```

```
$ reggie run examples/add 0 75 25
>>> R0: 100, R1: -1, R2: -1
```

```
$ reggie step examples/add 0 3 4
R0- -> L0, L1    ==> (L0, R0: 0, R1: 3, R2: 4)
R1- -> L2, L3    ==> (L1, R0: 0, R1: 3, R2: 4)
R0+ -> L1        ==> (L2, R0: 0, R1: 2, R2: 4)
R1- -> L2, L3    ==> (L1, R0: 1, R1: 2, R2: 4)
R0+ -> L1        ==> (L2, R0: 1, R1: 1, R2: 4)
R1- -> L2, L3    ==> (L1, R0: 2, R1: 1, R2: 4)
R0+ -> L1        ==> (L2, R0: 2, R1: 0, R2: 4)
R1- -> L2, L3    ==> (L1, R0: 3, R1: 0, R2: 4)
R2- -> L4, L5    ==> (L3, R0: 3, R1: 0, R2: 4)
R0+ -> L3        ==> (L4, R0: 3, R1: 0, R2: 3)
R2- -> L4, L5    ==> (L3, R0: 4, R1: 0, R2: 3)
R0+ -> L3        ==> (L4, R0: 4, R1: 0, R2: 2)
R2- -> L4, L5    ==> (L3, R0: 5, R1: 0, R2: 2)
R0+ -> L3        ==> (L4, R0: 5, R1: 0, R2: 1)
R2- -> L4, L5    ==> (L3, R0: 6, R1: 0, R2: 1)
R0+ -> L3        ==> (L4, R0: 6, R1: 0, R2: 0)
R2- -> L4, L5    ==> (L3, R0: 7, R1: 0, R2: 0)
HALT             ==> (L5, R0: 7, R1: 0, R2: 0)
```

# To Do

- [x] Erroneous halting
- [x] Decoding programs
- [x] Add support for custom initial register states
- [ ] More detailed parsing / lexical errors
- [ ] Functions / modules (Gadgets)
- [ ] Custom labels
- [x] Comments
