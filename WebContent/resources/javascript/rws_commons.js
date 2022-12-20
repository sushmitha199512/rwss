// rws_commons.js

/*   Color Change Text
This script and many more from - 
http://rainbow.arch.scriptmania.com/scripts/ 
*/

//   Change next line for your text msg.

var msg = 'Rural Water Supply & Sanitation'
var colorTimer = null;

//  Color can be altered below - eg. remove - ABCDEF = darker

function toHex(n){
var hexChars = '0123456789ABCDEF';
if (n == 0) return n;
var j, k;
var temp = '';
while (n != 0){
j = n % 16;
n = (n - j)/16;
temp = hexChars.charAt(j) + temp;
}
return temp;
}
function colorize(){
if (!document.getElementById) return;
for (i=0; i<msg.length; i++){
k = Math.round(Math.random() * 16777215);
k = toHex(k);
while (k.length < 6){
k = k + '0';
}
document.getElementById('colorizer' + i).style.color = '#' + k;
}

//  Speed change below - Default = 200 - Lower = Faster 

colorTimer = window.setTimeout('colorize()', 200);
}
