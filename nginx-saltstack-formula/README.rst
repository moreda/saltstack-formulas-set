=============
nginx-formula
=============

A saltstack formula to manage nginx.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``nginx``
---------

Installs the nginx package, and starts the associated nginx service.

``nginx.conf``
--------------

Configures the nginx package.

``nginx.ssl``
-------------

Puts in place SSL certificates and keys.

``nginx.users``
---------------

Creates user and group for the service.
