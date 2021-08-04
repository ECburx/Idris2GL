.. _sect-starting:

***************
Getting Started
***************

Installing from the Source Repo
===============================

Assuming you have `Idris 2 <https://idris2.readthedocs.io/>`_ already.

::

   git clone https://github.com/ECburx/Idris2GL


Install from Shared Objects
---------------------------

You can install IdrisGL without installing SDL dependencies, by provided compiled ``.so``
library files which could be found in ``src/c_src``.

::

   cd Idris2GL
   make fromso

Install from Source Code
------------------------

You may want to compiled shared libraries with your own SDLs.
To build from source code, you need to install SDL dependencies.

- SDL
- SDL_image
- SDL_ttf
- SDL_gfx

For users who installed **Advanced Packaging Tool**:

::

   apt update
   apt-get install libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl-ttf2.0-dev
   apt-get install libsdl2-image-dev
   apt-get install libsdl2-ttf-dev
   apt-get install libsdl-gfx1.2-dev

::

   cd Idris2GL
   make fromsrc


Additional installation options
-------------------------------

::

   cd src/c_src

-  ``make build`` builds shared libraries.
-  ``make install`` install shared libraries to idris2 system library directory.

::

   cd src

-  ``idris2 --build idrisGL.ipkg`` builds the library.
-  ``idris2 --install idrisGL.ipkg`` install the library.
-  ``idris2 --clean idrisGL.ipkg`` cleans everything.
-  ``idris2 --mkdoc idrisGL.ipkg`` generates HTML documentation for IdrisGL, output to ``build/docs``.

Checking Installation
=====================

Once the IdrisGL package has been installed, the command line option ``--package idrisGL``
makes it accessible (abbreviated to ``-p idrisGL``).

::

   idris2 -p idrisGL

If no error occurred, the IdrisGL should be successfully installed.

Import Things You Need
======================

-  ``import IdrisGL``: basic IdrisGL functions.
-  ``import IdrisGL.Color``: predefined colors.
-  ``import IdrisGL.Random``: unsafe, predictable and limited randomness,
   for users who need (inaccurate) random data to test graphics.
   (May be removed in the future.)
-  ``import IdrisGL.SDL``: SDL2, SDL2_image, SDL2_gfx, SDL2_ttf bindings.

.. note::

   You should use provided APIs instead of directly use SDL bindings.
   Considering that IdrisGL currently provides the most comprehensive SDL bindings,
   these bindings can be imported and used by users temporarily.
   However, these bindings may be moved to other packages in the future and cannot be imported directly in IdrisGL.