# Documentation for the IdrisGL

*README is derived from [Documentation for the Idris Language](https://github.com/edwinb/Idris2/tree/main/docs).*

This manual has been prepared using ReStructured Text and the Sphinx Documentation Generator for future inclusion on Read The Docs.

## Dependencies

To build the manual, the following dependencies must be met. We assume that you have standard build automation tools already installed i.e. make.

### Sphinx-Doc

Python should be installed by default on most systems. Sphinx can be installed either through your hosts package manager, using pip/easy_install or `pip install sphinx`. Recommended way is to use virtual environment for building documentation.

The ReadTheDocs theme can be installed in virtual environment using pip as follows:

```
pip install sphinx_rtd_theme
```

## Build Instructions

```
cd docs
make html
```
