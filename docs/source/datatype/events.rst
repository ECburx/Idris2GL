.. _sect-events:

*********************************
List of Events Defined in ``Eve``
*********************************

Keyboard Events
^^^^^^^^^^^^^^^

``E_KEYDOWN Key``
=================

Key pressed event.

.. code-block:: idris

    E_KEYDOWN EK_w -- `w` pressed event.
  
``E_KEYUP Key``
===============

Key released event.

.. code-block:: idris

    E_KEYUP EK_w -- `w` released event.

Mouse events
^^^^^^^^^^^^

``E_MOUSEMOTION (Int, Int)``
============================

Moving mouse and its position.

.. code-block:: idris

    E_MOUSEMOTION (x, y) -- mouse is moving, and its position.

``E_L_MOUSEBUTTONDOWN (Int, Int)``
==================================

Mouse left button pressed and its position.

``E_M_MOUSEBUTTONDOWN (Int, Int)``
==================================

Mouse middle button pressed and its position.

``E_R_MOUSEBUTTONDOWN (Int, Int)``
==================================

Mouse right button pressed and its position.

``E_L_MOUSEBUTTONUP (Int, Int)``
================================

Mouse left button released and its position.

``E_M_MOUSEBUTTONUP (Int, Int)``
==================================

Mouse middle button released and its position.

``E_R_MOUSEBUTTONUP (Int, Int)``
================================

Mouse right button released and its position.

``E_MOUSEWHEEL (Int, Int)``
===========================

Mouse wheel event and its position.

.. note::

    Support wheel directions in the future.