================
php5-formula
================

A saltstack formula to manage php5 and php5-fpm.

.. note::

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``php5``
------------

Installs the php5 package.

``php5.repo``
------------

In case of Debian os_family, configures ondrej/php5 PPA with updated php5
related packages

``php5.curl``
------------

Installs the php5-curl package.

``php5.mysql``
------------

Installs the php5-mysql package.

``php5.fpm``
------------

Installs the php5-fpm package.

``php5.fpm.conf``
------------

Configures the php5-fpm package.

``php5.fpm.repo``
------------

In case of Debian os_family, configures ondrej/php5 PPA with updated php5
related packages
