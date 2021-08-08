.. _sect-pictures:

***************************************
List of Pictures Defined in ``Picture``
***************************************

Basic
^^^^^

``Blank``
=========

A blank picture, with nothing in it.

.. code-block:: idris

   Blank : Picture

``Pictures``
============

| A picture consisting of several others.
| @ pics    Other pictures.

.. code-block:: idris

    Pictures 
        :  (pics : List Picture) 
        -> Picture

``Rotate``
==========

| A picture rotated clockwise by the given angle (in degrees) and given center.
| @ angle   Rotation angle.
| @ center  Rotation center.
| @ pic     The picture to be rotated.

.. code-block:: idris

    Rotate 
        :  (angle  : Double) 
        -> (center : Coordinate) 
        -> (pic    : Picture) 
        -> Picture

Images
^^^^^^

``Bitmap``
==========

| A bitmap image.
| @ path The path of the bitmap.
| @ rect The size and position of placed bitmap.

.. code-block:: idris

    Bitmap 
        :  (path : String) 
        -> (rect : Rect) 
        -> Picture

``Image``
=========

| An image in other format (PNG/JPG/WEBP/TIF).
| @ path The path of the image.
| @ rect The size and position of placed image.

.. code-block:: idris

    Image 
        :  (path : String) 
        -> (rect : Rect) 
        -> Picture

shapes
^^^^^^

``Pixel``
=========

| A pixel at given coordinate.
| @ position The position of the pixel.
| @ color    The color of the pixel.

.. code-block:: idris

    Pixel 
        :  (position : Coordinate) 
        -> (color    : Color) 
        -> Picture

``ThickLine``
=============

| A thick line with given thickness.
| @ start     The start position.
| @ end       The end position.
| @ color     The color of line.
| @ thickness The thickness of line.

.. code-block:: idris

    ThickLine 
        :  (start     : Coordinate) 
        -> (end       : Coordinate) 
        -> (color     : Color) 
        -> (thickness : Int) 
        -> Picture

``Line``
========

| @ start     The start position.
| @ end       The end position.
| @ color     The color of line.

.. code-block:: idris

    Line 
        :  (start : Coordinate) 
        -> (end   : Coordinate) 
        -> (color : Color) 
        -> Picture

``Rectangle``
=============

| @ rect    The size of position of the rectangle.
| @ color   The color of the rectangle.
| @ filling True if fill the rectangle. 

.. code-block:: idris

    Rectangle 
        :  (rect    : Rect) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> Picture

``R_Rectangle``
===============

| A rounded-corner rectangle. 
| @ rect    The size of position of the rectangle.
| @ color   The color of the rectangle.
| @ filling True if fill the rectangle. 
| @ radius  The radius of the corner arc.

.. code-block:: idris

    R_Rectangle 
        :  (rect    : Rect) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> (radius  : Int) 
        -> Picture

``Circle``
==========

| @ center  The center of the circle.
| @ color   The color of the circle.
| @ filling True if fill the circle.
| @ radius  The radius of the circle.

.. code-block:: idris

    Circle 
        :  (center  : Coordinate) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> (radius  : Int) 
        -> Picture

``ThickCircle``
===============

| A circle with given thickness.
| @ center    The center of the circle.
| @ color     The color of the circle.
| @ filling   True if fill the circle.
| @ radius    The radius of the circle.
| @ thickness The thickness of the drawing line.

.. code-block:: idris

    ThickCircle 
        :  (center    : Coordinate) 
        -> (color     : Color)
        -> (radius    : Int)
        -> (thickness : Int)
        -> Picture

``Arc``
=======

| A circular arc drawn counter-clockwise between two angles (in degrees).
| @ center The center of the arc.
| @ color  The color of drawing line.
| @ radius The radius of the arc.
| @ start  Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
| @ end    Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise. 

.. code-block:: idris

    Arc 
        :  (center : Coordinate) 
        -> (color  : Color) 
        -> (radius : Int) 
        -> (start  : Int) 
        -> (end    : Int) 
        -> Picture

``Pie``
=======

| A pie (outline) drawn counter-clockwise between two angles (in degrees).
| @ center The center of the pie.
| @ color  The color of drawing line.
| @ radius The radius of the pie.
| @ start  Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
| @ end    Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.

.. code-block:: idris

    Pie 
        :  (center : Coordinate) 
        -> (color  : Color) 
        -> (radius : Int) 
        -> (start  : Int) 
        -> (end    : Int) 
        -> Picture

``Ellipse``
===========

| @ center  The center of the ellipse.
| @ rx      Horizontal radius in pixels of the ellipse. 
| @ ry      Vertical radius in pixels of the ellipse. 
| @ color   The color of drawing line.
| @ filling True if fill the ellipse.

.. code-block:: idris

    Ellipse 
        :  (center  : Coordinate) 
        -> (rx      : Int) 
        -> (ry      : Int) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> Picture

``Trigon``
==========

| @ point1  The first point.
| @ point2  The second point.
| @ point3  The third point.
| @ color   The color of drawing line.
| @ filling True if fill the trigon.

.. code-block:: idris

    Trigon 
        :  (point1  : Coordinate) 
        -> (point2  : Coordinate) 
        -> (point3  : Coordinate) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> Picture

``Polygon``
===========

| @ points  A list of points.
| @ color   The color of drawing line.
| @ filling True if fill the trigon.

.. code-block:: idris
    
    Polygon 
        :  (points  : List Coordinate) 
        -> (color   : Color) 
        -> (filling : Bool) 
        -> Picture

Text
^^^^

``Text``
========

| Blended text with default settings.
| @ text  Text.
| @ size  Font size.
| @ font  Path of font file.
| @ pos   Position of text.
| @ color The color of text.

.. code-block:: idris

    Text 
        :  (text  : String) 
        -> (size  : Int) 
        -> (font  : String)
        -> (pos   : Coordinate) 
        -> (color : Color) 
        -> Picture

``SolidText``
=============

| Solid text.
| @ text    Text.
| @ size    Font size.
| @ font    Path of font file.
| @ pos     Position of text.
| @ color   The color of text.
| @ style   Font style.
| @ hinting Hinting.
| @ kerning Kerning.

.. code-block:: idris

    SolidText 
        :  (text    : String) 
        -> (size    : Int)
        -> (font    : String) 
        -> (pos     : Coordinate) 
        -> (color   : Color) 
        -> (style   : TextStyle) 
        -> (hinting : TextHinting) 
        -> (kerning : Int) 
        -> Picture

``BlendedText``
===============

| Blended text.
| @ text    Text.
| @ size    Font size.
| @ font    Path of font file.
| @ pos     Position of text.
| @ color   The color of text.
| @ style   Font style.
| @ hinting Hinting.
| @ kerning Kerning.

.. code-block:: idris

    BlendedText 
        : (text     : String) 
        -> (size    : Int) 
        -> (font    : String) 
        -> (pos     : Coordinate) 
        -> (color   : Color) 
        -> (style   : TextStyle) 
        -> (hinting : TextHinting) 
        -> (kerning : Int) 
        -> Picture

``ShadedText``
==============

| Shaded text. (Blended text with background color)
| @ text    Text.
| @ size    Font size.
| @ font    Path of font file.
| @ pos     Position of text.
| @ color   The color of text.
| @ bgColor The background color.
| @ style   Font style.
| @ hinting Hinting.
| @ kerning Kerning.

.. code-block:: idris

    ShadedText 
        :  (text    : String) 
        -> (size    : Int) 
        -> (font    : String) 
        -> (pos     : Coordinate) 
        -> (color   : Color) 
        -> (bgColor : Color)
        -> (style   : TextStyle) 
        -> (hinting : TextHinting) 
        -> (kerning : Int) 
        -> Picture
