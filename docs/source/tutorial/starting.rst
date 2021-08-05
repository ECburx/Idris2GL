.. _sect-starting:

***************
Getting Started
***************

Installing from the Source Repo
===============================

Assuming you have `Idris 2 <https://idris2.readthedocs.io/>`_ already.

Install from Source Code
------------------------

::

   git clone https://github.com/ECburx/Idris2GL
   cd Idris2GL
   make quickInstall

.. note::

   You may want to compiled shared libraries with your own SDLs.
   Following SDL dependencies is required:

   - SDL
   - SDL_image
   - SDL_ttf
   - SDL_gfx

   After you installed these dependencies, 

   ::

      cd Idris2GL
      make install


Additional installation options
-------------------------------

-  ``make clean`` cleans everything.
-  ``make prebuild`` build shared libraries without installing them.

-  ``cd src/c_src``

   -  ``make build`` builds shared libraries.
   -  ``make install`` install shared libraries to idris2 system library directory.

-  ``cd src``

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

.. warning::

   | You should use provided APIs instead of SDL bindings.
   | Considering that IdrisGL currently provides the most comprehensive SDL bindings,
     these bindings can be imported and used by users temporarily.
     However, these bindings may be moved to other packages in the future and cannot be imported directly from IdrisGL.