# salt-formulas-set

This is a complete set of saltstack formulas that I developed for personal
usage. Some of them are available as independent ones either as personal repos
or official saltstack-formulas.

All of them share a rationale that I'll document explicitly (TBD).

The subdirectories \*-saltstack-formula could be stacked in your file\_roots to
give you ready-to-use states to manage your systems.


## General customization strategies

* **Use pillar data**. This is the absolutely recommended way to use the
  formulas. In most occassions all you need is to fill some of the key-values
  shown in the ``pillar.example`` file. If you feel that a certain value
  should be there then don't hesitate to propose an enhancement.

* Use the ``extra_conf`` key that in some cases is present in the pillar to add
  arbitrary configuration lines in the templates provided. This is a way to have
  a better customization without over-populating the pillar with new key-values.

* Add new subdirectories under ``files`` in addition to ``default``. This
  new subdirectories will contain different files to be used in certain
  conditions. This selection mechanism is based by default in the ``ìd`` grain
  of the minion (i.e. if there's a new subdirectory named ``minion01`` then
  the formula is going to look there first for that minion). This selection
  behavior can be extended to make it depend on any sorted list of grains,
  defined by the key ``files_switch``.

  For example, let's define in pillar something like:

  .. code:: yaml

      formula-name:
        files_switch: ['id', 'os_family']

  Let's have this ``files`` directory structure:

  .. code:: asciidoc

      files
        |-- minion01
        |       `-- etc
        |            `-- foo.conf.jinja
        |-- Debian
        |       `-- etc
        |            `-- foo.conf.jinja
        `-- default
                |-- etc
                |    |-- foo.conf.jinja
                |    `-- bar.conf.jinja
                `-- usr/share/thingy/*

  With this, we have the following:

  * if the minion id is ``minion01`` then ``files/minion01/etc/foo.conf.jinja``
    is going to be used

  * else if the minion os_family is ``Debian`` then
    ``files/Debian/etc/foo.conf.jinja`` is going to be used

  * else ``files/default/etc/foo.conf.jinja`` is going to be used

  Beware: **this is not designed to substitute pillar data**. Remember that
  pillar has to be used for information that it's essential to be only known for
  a certain set of minions (i.e. passwords, private keys and such).

* As a last resort you can actually fork the formula to suit your needs, keeping
  an eye for further improvements to merge into yours. Of course any pull-
  request that you can bring back it would be taken in account ;-)


## Useful commands

Add remotes for the repo-per-formula and add them as subtrees:

```bash
FORMULAS="apache mysql nginx php5 shorewall sudo system users varnish zabbix"
for i in $FORMULAS
  do
    git remote add -f $i-saltstack-formula \
      git@github.com:moreda/$i-saltstack-formula.git
    git subtree add -P $i-saltstack-formula $i-saltstack-formula master
  done
```

Pull all the repo-per-formula subtrees:

```bash
FORMULAS="apache mysql nginx php5 shorewall sudo system users varnish zabbix"
for i in $FORMULAS
  do
    git subtree pull -P $i-saltstack-formula $i-saltstack-formula master
  done
```
