// ReqFormValidations.js

function getTotPartAAmount(){
var pamount=parseFloat(document.getElementById('partAAmount').value);
pamount=pamount*100000;
return pamount;
}

function getTotCharges(){
var lanCharges=document.getElementById('landAquisitionChrg').value;
var watCharges=document.getElementById('waterDrawlPermissionChrg').value;
var railCharges=document.getElementById('railwayCrossingPermissionChrg').value;
var roadCharges=document.getElementById('roadCrossingPermissionChrg').value;
var roadCharges1=document.getElementById('roadCrossingPermissionNHAIChrg').value;
var forestCharges=document.getElementById('forestClearanceChrg').value;
var powerCharges=document.getElementById('powerAPTranscoChrgs').value;
var hmwsCharges=document.getElementById('hmwsChrgs').value;
var otherCharges=document.getElementById('othersChrg').value;


var groundWaterInvestigationChg=document.getElementById('groundWaterInvestigationChg').value;
var yieldTestingChg=document.getElementById('yieldTestingChg').value;
var sourceCreationChg=document.getElementById('sourceCreationChg').value;
var dprCharges=document.getElementById('dprCharges').value;

var tot=0;
if(lanCharges!=""){
tot=tot+ parseFloat(lanCharges);
}
if(watCharges!=""){
tot=tot+ parseFloat(watCharges);
}
if(railCharges!=""){
tot=tot+ parseFloat(railCharges);
}

if(roadCharges!=""){
tot=tot+ parseFloat(roadCharges);
}
if(roadCharges1!=""){
tot=tot+ parseFloat(roadCharges1);
}
if(forestCharges!=""){
tot=tot+ parseFloat(forestCharges);
}
if(powerCharges!=""){
tot=tot+ parseFloat(powerCharges);
}
if(hmwsCharges!=""){
tot=tot+ parseFloat(hmwsCharges);
}
if(otherCharges!=""){
tot=tot+ parseFloat(otherCharges);
}

if(groundWaterInvestigationChg!=""){
tot=tot+ parseFloat(groundWaterInvestigationChg);
}
if(yieldTestingChg!=""){
tot=tot+ parseFloat(yieldTestingChg);
}
if(sourceCreationChg!=""){
tot=tot+ parseFloat(sourceCreationChg);
}
if(dprCharges!=""){
tot=tot+ parseFloat(dprCharges);
}
return tot;
}


function totCheck(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();
if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('landAquisitionChrg').value="";
    return;
}

}



}
//***********************


function totCheck1(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('waterDrawlPermissionChrg').value="";
    return;
}

}



}
///*****************/

function totCheck2(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('railwayCrossingPermissionChrg').value="";
    return;
}

}



}

function totCheck3(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();
if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('roadCrossingPermissionChrg').value="";
    return;
}

}



}

function totCheck4(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('roadCrossingPermissionNHAIChrg').value="";
    return;
}

}



}

function totCheck5(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('forestClearanceChrg').value="";
    return;
}

}



}

function totCheck6(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('powerAPTranscoChrgs').value="";
    return;
}

}



}

function totCheck7(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('hmwsChrgs').value="";
    return;
}

}



}


function totCheck8(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('othersChrg').value="";
    return;
}

}



}

function totCheck9(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('groundWaterInvestigationChg').value="";
    return;
}

}



}

function totCheck10(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('yieldTestingChg').value="";
    return;
}

}



}

function totCheck11(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('sourceCreationChg').value="";
    return;
}

}



}

function totCheck12(){
var pamount=getTotPartAAmount();

var tot=getTotCharges();

if(pamount==0){ 
 alert("Please Enter Part A Amount");
}else{
if(tot>pamount){
	alert("Amount Should Not Be exceded to PartA Amount");
document.getElementById('dprCharges').value="";
    return;
}

}



}
