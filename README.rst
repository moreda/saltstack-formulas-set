=============
mysql-formula
=============

A saltstack formula to manage mysql.

.. note::

    So far we don't manage the mysql conf. This is just a basic utility formula
    that I needed to use from others.

    See the full `Salt Formulas
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_ doc.

Available states
================

.. contents::
    :local:

``mysql.server``
----------------

Installs the mysql-server package and starts the associated service.

``mysql.server.conf``
---------------------

Configures the mysql-server package. This state just includes ``mysql.conf`` and
sets the adequate requisites.

``mysql.client``
----------------

Installs the mysql-client package.

``mysql.client.conf``
---------------------

Configures the mysql-client package. This state just includes ``mysql.conf`` and
sets the adequate requisites.

``mysql.python``
----------------

Installs the python-mysqldb package needed for the mysql related modules in
salt. This sls is included by default in the mysql.server and mysql.client sls
files.
