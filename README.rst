================
shorewall-formula
================

A saltstack formula to manage shorewall. Shorewall is a complex piece of
software that could make your minion inaccesible if care is not taken.

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``shorewall``
------------

Installs the shorewall package, and starts the associated shorewall service.

``repo``
------------

Configures shorewall repository to the PPA of Allenta (Shorewall 4.x for Ubuntu
Precise)

``config``
------------

Configures the shorewall package.
