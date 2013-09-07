all:		compile run_test clean


compile:
				erlc -o ebin/ src/*.erl
				erlc -o ebin/ test/*.erl

run_test:
					erl -pa ebin \
					-env ERL_LIBS deps/ \
					-eval 'eunit:test("ebin").' \
					-s init stop

clean: 
			rm -rf ebin/*.beam 
			rm -rf erl_crash.dump
