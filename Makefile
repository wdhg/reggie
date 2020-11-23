all: src/Tokens.x src/Grammer.y
	alex src/Tokens.x
	happy src/Grammer.y

clean:
	rm -rf src/Tokens.hs src/Grammer.hs
