.. _sect-play:

****
Play
****

IdrisGL supports most of the keyboard and mouse events.
It's time to interact our pictures with outside world.

In this chapter, we will handles user-inputed events,
and dig further of StateT in IdrisGL.

Manage Input Events
===================

``play`` plays a game in a window. Like simulate, but you manage your own input events.

.. code-block:: idris
   :caption: ``play``

   play 
     :  (window  : Display)
     -> (bgColor : Color)
     -> (tpf     : Double)
     -> (world   : a)
     -> (w2p     : a      -> Picture)
     -> (ew2w    : Eve    -> a -> a)
     -> (tw2w    : Double -> a -> a)
     -> IO ()

-  ``world``: the initial game world, of some generic type ``a``.
   You can consider it as a model in ``simulate``.
-  ``w2p`` : a function tells IdrisGL how to display a world.
-  ``ew2w``: a function handles input events, and step the world.
-  ``tw2w``: similar to ``m2m`` in ``simulate``, except that it uses the passed time to step the world.
   If the stepping of world doesn't depend on time. Your function can ignore the time IdrisGL passed.

As usual, let's introduce events by a simple example.

An Example of Tracking Mouse Events
===================================

`Example Code: Mouse Events
<https://github.com/ECburx/Idris2GL/tree/main/samples/play_mouseEvents/>`_
