\p 5000

\l html.q
\l blogFns.q

system"cd files"
binary:loadData each hsym key `:.
system"cd .."

saveData[`:hdb;`binary]
\l hdb
