.. _sect-starting:

***************
Getting Started
***************

Dependencies
============

- SDL2
- SDL2 Image
- SDL2 GFX
- SDL2 TTF
- SDL2 Mixer

::

   sudo apt update && sudo apt upgrade
   sudo apt-get install libsdl1.2-dev libsdl-image1.2-dev libsdl-mixer1.2-dev libsdl2-image-dev libsdl2-ttf-dev libsdl2-gfx-dev libsdl2-mixer-dev

Install with [Pack](https://github.com/stefan-hoeck/idris2-pack)
================================================================

- Assuming you have installed `Pack <https://github.com/stefan-hoeck/idris2-pack>`_.
- Install all the dependencies using the commands above.
- Make sure you added ``idris2`` to ``$PATH``.
- ``pack install idrisGL``

.. note:: 

   **Unable to install with Pack?**

   - **`make[1]: idris2: No such file or directory`**: Make sure you added `idris2` to `$PATH`.
  
   - **Errors caused by `include <SDL....>` or `SDL not found`**: Install all the dependencies using the [commands](#dependencies) above.

   - **Not on the list?** Check [Pack Nightly Build](https://github.com/stefan-hoeck/idris2-pack-db) and report an issue if it is related to IdrisGL.

Install from Source Code
========================

- `git clone https://github.com/ECburx/Idris2GL`
- Navigate to the directory: `cd Idris2GL`
- Make sure you added `idris2` to `$PATH`.
- If you have installed all the dependencies, `make install`
- Otherwise, `make quickInstall`. This will install the dependencies for you.

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