\p 5000
\c 25 200

\l html.q
\l blogFns.q

system"cd files"
files:hsym key `:.
binary:loadData each files
system"cd .."

saveData[`:hdb;`binary]
\l hdb
