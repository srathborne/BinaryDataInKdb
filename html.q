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
encodeImg:{""sv("<img width='320' height='240' src='data:image/jpeg;base64,";.Q.btoa x;"'/>")}
encodeAudio:{""sv("<audio controls src='data:audio/ogg;base64,";.Q.btoa x;"'/>")}
encodePdf:{""sv ("<embed src='data:application/pdf;base64,"; .Q.btoa x; "'/>")}
encodeVideo:{[x;y] "" sv ("<video controls width='320' height='240' source type='video/"; x; "' src='data:video/"; x:string x; ";base64,"; .Q.btoa y; "'/></video>")}
encodeMap:`jpeg`jpg`png`oga`wav`pdf!(encodeImg;encodeImg;encodeImg;encodeAudio;encodeAudio;encodePdf)

encodeDownload:{[x;y;z] ""sv("<a download=";raze("'";string` sv(y;z);"'");" href='data:image.jpeg;base64,";.Q.btoa x;"'/> downloadFile")}

/ tag url filepaths
tagRef:{""sv ("<embed width='320' height='=240' src='"; x; "'/>")}
tagCsv:{""sv ("<object type='text/plain' width='320' height='=240' data='"; x; "'/>")}
tagVideoRef:{""sv ("<video controls width='320' height='=240' src='";x;"'/>")}
tagAudioRef:{""sv("<audio controls src='";x;"'/>")}
tagMap:`jpeg`jpg`png`txt`pdf`csv`oga`wav`mp4`flv`webm!(tagRef;tagRef;tagRef;tagRef;tagRef;tagRef;tagAudioRef;tagAudioRef;tagVideoRef;tagVideoRef;tagVideoRef)
tagDownload:{""sv("<a download href='";x;"'/> downloadFile")}

encodeData:{[tab]
    tab:update kdbViewer:encodeMap[extension]@'data from tab where extension in key encodeMap;
    tab:update kdbViewer:encodeVideo'[extension;data] from tab where extension in `mp4`flv`webm;
    tab:update kdbDownload:encodeDownload'[data;filename;extension] from tab;

    tab:update filepathDwn:tagDownload each filepath from tab;
    tab:update filepath:tagMap[extension]@'filepath from tab where extension in key tagMap;

    `filename`extension`kdbViewer`kdbDownload`filepath`filepathDwn xcols tab
 }
