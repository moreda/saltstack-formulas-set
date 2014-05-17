==============
system-formula
==============

A saltstack formula to manage miscelaneous system settings.

This formula is ment to be forked to suit the particular needs of each case.
Initially it was thought as a way to contains all the configurations not in
"full-fledged" formulas (as apache. mysql, varnish, etc ones).

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``packages``
------------

Installs a set of packages based in info provided in pillar.
