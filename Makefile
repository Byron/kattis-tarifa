help:
	$(info -Targets -----------------------------------------------------------------------------)
	$(info init                         | NAME=kattis-name - download the samples for tests)
	$(info exe                          | build the executable)
	$(info fmt                          | format the code with rustfmt)
	$(info journey-tests                | run all stateless journey test)
	$(info continuous-journey-tests     | run all stateless journey test whenever something changes)

init:
	wget https://open.kattis.com/problems/$(NAME)/file/statement/samples.zip && \
	    unzip samples.zip -d tests/samples/ && \
	    rm samples.zip

fmt: src/main.rs
	rustfmt $<
	
exe: src/main.rs
	rustc  -C opt-level=3 --crate-type bin -o $@ src/main.rs

journey-tests: ./exe
	./tests/stateless-journey.sh ./exe

continuous-journey-tests:
	watchexec $(MAKE) journey-tests

