This is a complete set of saltstack formulas that I developed for personal
usage.

The subdirectories *-saltstack-formula could be stacked in your file_roots to
give you ready-to-use states to manage your systems.

FORMULAS="apache mysql nginx php5 shorewall sudo system users varnish zabbix"
for i in $FORMULAS
  do
    git remote add -f $i-saltstack-formula https://github.com/moreda/$i-saltstack-formula.git
    git subtree add -P $i-saltstack-formula $i-saltstack-formula master
  done
