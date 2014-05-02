============
php5-formula
============

A saltstack formula to manage php5 and php5-fpm.

This formula has been developed distributing id and state declarations in
different files to make it usable in most situations. It should be useful from
scenarios with a simple install of the package (without any special
configuration) to a complete set-up with virtual hosts.

Any special needs could be addressed forking the formula repo, even in-place at
the server acting as master. I'm trying to keep this as general as possible and
further general improvements would be added.

The ``files`` directory is structured using a ``default`` root and
optional ``<minion-id>`` directories:

.. code:: asciidoc

    files
      |-- default
      |        |-- etc
      |        |    |-- foo.conf
      |        |    `-- bar.conf
      |        `-- usr/share/thingy/*
      `-- <minion-id>
              |-- etc
              |    |-- foo.conf
              |    `-- bar.conf
              `-- usr/share/thingy/*

This way we have certain flexibility to use different files for different
minions. **It's not designed to substitute pillar data**. Remember that
pillar has to be used for info that it's essential to be only known for a
certain set of minions (i.e. passwords, private keys and such).

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
