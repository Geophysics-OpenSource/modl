PYTHON ?= python
PYTEST ?= py.test --pyargs
DATADIR=$(HOME)/modl_data

# Compilation...

in: inplace

inplace:
	$(PYTHON) setup.py build_ext -i

install:
	$(PYTHON) setup.py install

clean:
	rm -f `find modl -name "*.so"`
	rm -f `find modl -name "*.pyx"  | sed s/.pyx/.html/g`
	rm -f `find modl -name "*.pyx"  | sed s/.pyx/.c/g`
	rm -f `find modl -name "*.pyx"  | sed s/.pyx/.cpp/g`
	rm -rf htmlcov
	rm -rf build
	rm -rf coverage .coverage
	rm -rf .cache
	rm -rf modl.egg-info
	rm -rf dist

# Tests
#
test:
	cd /tmp
	$(PYTEST) modl

test-coverage:
	rm -rf coverage .coverage
	rm -rf dist
	rm -f `find modl -name "*.so"`
	$(PYTHON) setup.py build_ext -i -D CYTHON_TRACE -D CYTHON_TRACE_NOGIL
	$py.test modl --cov=modl --cov-config=.coveragerc

# Data
#
datadir:
	mkdir -p $(DATADIR)

download-images: datadir
	./misc/download.sh http://www.amensch.fr/data/images.tar.bz2
	tar xvfj images.tar.bz2
	mv -f images $(DATADIR)
	rm images.tar.bz2

download-movielens: datadir download-movielens100k download-movielens1m download-movielens10m

download-movielens100k: datadir
	./misc/download.sh http://www.mblondel.org/data/movielens100k.tar.bz2
	tar xvfj movielens100k.tar.bz2
	mv -f movielens100k $(DATADIR)
	rm movielens100k.tar.bz2


download-movielens1m: datadir
	./misc/download.sh http://www.mblondel.org/data/movielens1m.tar.bz2
	tar xvfj movielens1m.tar.bz2
	mv -f movielens1m $(DATADIR)
	rm movielens1m.tar.bz2


download-movielens10m: datadir
	./misc/download.sh http://www.mblondel.org/data/movielens10m.tar.bz2
	tar xvfj movielens10m.tar.bz2
	mv -f movielens10m $(DATADIR)
	rm movielens10m.tar.bz2
