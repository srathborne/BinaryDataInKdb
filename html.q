/ function that takes in a table and outputs a html format of it 
htmlTab:{[tab]
    header: enlist "<th>",("</th><th align='left'>"sv string cols tab),"</th>";();
    rows:"<td>",/:("</td><td>"sv/:{?[10h=type x;x;raze each'string x]}flip value flip tab),\:"</td>";
    "<table border='1'><tr>",("</tr>\r<tr>"sv header,rows),"</tr></table>"
 }

/ http get message handler
.z.ph:{[x]
    res:$[`=x:`$last"="vs first x; binary; value x];
    res:htmlTab delete data from encodeData[res];
    .h.hp enlist .h.html res
 }

/ encode binary data into base 64 (h5 compatible)
encodeImg:{""sv("<img src='data:image/jpeg;base64,";.Q.btoa x;"'/>")}
encodeAudio:{""sv("<audio controls src='data:audio/ogg;base64,";.Q.btoa x;"'/>")}
encodePdf:{""sv ("<embed src='data:application/pdf;base64,"; .Q.btoa x; "'/>")}
encodeVideo:{[x;y] "" sv ("<video width='320' height='240' controls> <source type='video/"; x; "' src='data:video/"; x:string x; ";base64,"; .Q.btoa y; "'/></video>")}
encodeDownload:{[x;y;z] ""sv("<a download=";raze("'";string` sv(y;z);"'");" href='data:image.jpeg;base64,";.Q.btoa x;"'/> downloadFile")}

functionMap:`jpeg`jpg`png`oga`wav`pdf!(encodeImg;encodeImg;encodeImg;encodeAudio;encodeAudio;encodePdf)

encodeData:{[tab]
    tab:update viewer:functionMap[extension]@'data from tab where extension in key functionMap;
    tab:update viewer:encodeVideo'[extension;data] from tab where extension in `mp4`flv`webm;
    tab:update download:encodeDownload'[data;filename;extension] from tab;
    tab
 }
