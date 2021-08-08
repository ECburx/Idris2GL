.. _sect-datatypes:

*********************
Begin with Data Types
*********************

Before we begin exploring, we'll look at some basic types and data types of IdrisGL,
and you will see how they works in IdrisGL.

Coordinates
===========

IdrisGL specifies the position of a window on the screen in ``Coordinate``.
For screen coordinates, the origin is the upper-left corner of the screen.
And the position of a pixel can also be considered as a coordinate.

.. code-block:: idris
   :caption: ``Coordinate``

   data Coordinate : Type where
      ||| @ x X coordinate of the point.
      ||| @ y Y coordinate of the point.
      MkCoor : (x : Int) -> (y : Int) -> Coordinate

``Coordinate`` takes two parameters, *x* coordinate and *y* coordinate.
Imaging you have a 1080p screen (1920*1080),
the ``MkCoor 0 0`` point is in the upper left of the screen,
and the ``MkCoor 1920 1080`` point is at the lower right.

Rectangle
=========

``Rect`` is used to described a rectangle area.

The full position of a window is often described by a rectangle structure containing the
screen coordinates of two points that define the upper-left and lower-right corners of the window.
In IdrisGL, we describes this rectangle area by the upper-left point, the width and the height of it.

.. code-block:: idris
   :caption: ``Rect``

   data Rect : Type where
      ||| @ x X coordinate of the start point.
      ||| @ y Y coordinate of the start point.
      ||| @ w The width of the rectangle area.
      ||| @ h The height of the rectangle area.
      MkRect : (x : Int) -> (y : Int) -> (w : Int) -> (h : Int) -> Rect

.. image:: img/Rect1.png
   :scale: 70 %
   :align: center

For example, ``MkRect 30 50 100 200`` describes a rectangle whose upper left corner is at (30, 50),
with a width of 100 and a height of 200.

Colors
======

IdrisGL supports RGB and RGBA colors.

.. code-block:: idris
   :caption: ``Color``

   data Color : Type where
        MkRGBA : (r : Int) -> (g : Int) -> (b : Int) -> (a : Int) -> Color
        MkRGB  : (r : Int) -> (g : Int) -> (b : Int) -> Color

Or you can ``import IdrisGL.Color`` to use predefined colors, such as red, green and blue.

Window
======

``Display`` data type describes how IdrisGL should display a window.

.. code-block:: idris
   :caption: ``Display``
   
   data Display
     = InWindow String Rect
     | FullWindow

-  ``InWindow <title> <window_pos_size>`` describes a window with the given title, position and size.
-  ``FullWindow`` displays full screen.

The following function describes a window starting at coordinates (30, 50),
with a width of 600 and a height of 300.

.. code-block:: idris
   
   window : Display
   window = InWindow "My First Window" (MkRect 30 50 600 300)

Picture
=======

Data type ``Picture`` declares all available window elements and their operations in Idris.
Here are some commonly used ``Picture`` elements:

-  A blank picture with nothing in it.

   .. code-block:: idris
      
      Blank : Picture

-  A line from one coordinate to the other, with specified color.

   .. code-block:: idris
      
      ||| @ start     The start position.
      ||| @ end       The end position.
      ||| @ color     The color of line.
      Line 
         :  (start : Coordinate) 
         -> (end   : Coordinate) 
         -> (color : Color) 
         -> Picture

-  A rectangle describes by a ``Rect``, with specified color and filling options.

   .. code-block:: idris

      ||| @ rect    The size of position of the rectangle.
      ||| @ color   The color of the rectangle.
      ||| @ filling True if fill the rectangle. 
      Rectangle 
         :  (rect    : Rect) 
         -> (color   : Color) 
         -> (filling : Bool) 
         -> Picture

We will introduce and discuss more pictures, shapes and operations of these in following chapters.

Events
======

If you don't want to handles input events (from computer devices),
you won't need to worry about this data type.
This data type is only used when *playing* something.

``Eve`` describes all available user input events in IdrisGL.
The ``play`` functions passes these events to you,
and you decides how to change medias corresponding with different events.

.. code-block:: idris
   :caption: ``Eve``

   data Eve 
      = E_UNAVAILABLE
      | E_QUIT
      {- Key events -}
      | E_KEYDOWN Key
      | E_KEYUP   Key
      {- Mouse events -}
      | E_MOUSEMOTION       (Int, Int)
      | E_L_MOUSEBUTTONDOWN (Int, Int)
      | E_M_MOUSEBUTTONDOWN (Int, Int)
      | E_R_MOUSEBUTTONDOWN (Int, Int)
      | E_L_MOUSEBUTTONUP   (Int, Int)
      | E_M_MOUSEBUTTONUP   (Int, Int)
      | E_R_MOUSEBUTTONUP   (Int, Int)
      | E_MOUSEWHEEL        (Int, Int)

``Key`` in key events is a data type represending different keyboard events.
For example, ``E_KEYUP EK_RETURN`` means releasing the *Return* button.

You can find all supported events in **List of Events Defined in ``Eve``**.