/ Read data in with read1 as a list of bytes
loadData:{[file]
    `filename`extension`kdbViewer`filepath`data!(`$1_first fn;`$last fn:"." vs string[file];"c"$data;"http://localhost:8000/",1_string file;data:read1 file)
 }

/ Save data into two tables, compressesd and uncompressed 
saveData:{[hdbDir;tab]
    (` sv hdbDir,tab,`) set .Q.en[hdbDir;]value tab;
    tab1:`$string[tab],"Compr";
    dir:` sv hdbDir,tab1,`;
    (dir;17;2;6)set .Q.en[hdbDir;]value tab
 }
