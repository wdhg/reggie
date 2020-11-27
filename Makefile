all: src/Parser/Tokens.x src/Parser/Grammer.y
	alex src/Parser/Tokens.x
	happy src/Parser/Grammer.y

clean:
	rm -rf src/Parser/Tokens.hs src/Parser/Grammer.hs

install: all
	stack install
