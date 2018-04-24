<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="system_Main" %>
<!-- #include file="lib/form.inc"  -->
<link href="lib/application.css"rel="stylesheet" />

<script>

System.Menu = this;
function setTabDelegate(fnName){
	delegateTab[delegateTab.length]  = fnName;
}
var delegateTab = new Array();

var lang="<%=Session["SESSION_LANG"]%>";
var _url, _Title, _lTitle, _fTitle, _menu_id,_menu_cd ,_menu_path;
var gReload = false;
function GetPageURL(){
    
    if(nPos > -1 && nCount > 0){
        var url = new String();
        var currForm = idContent.childNodes( nPos );
        var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
        url = frm.src;
       
       return url;
    }
    else{
        alert("There is nothing to view.");
        return "";
    }
}   
function ShowMenu()
{
	var obj = idWorkspace;
	
	
	if ( obj.style.visibility == "hidden" )
	{
		obj.style.visibility = "";	
		obj.style.display = "";
		obj.focus();
		imgShowMenu.style.display="none";
	} else
	{
		obj.style.visibility = "hidden";	
		obj.style.display = "none";
	}
}

function HideAppMenu()
{
	var obj = idWorkspace;
	obj.style.visibility = "hidden";	
	obj.style.display = "none";

	imgShowMenu.style.display="";
	imgShowMenu.style.visibility="";
}

function PinClick()
{
	var obj = event.srcElement;
	
	var pobj = obj;
	while ( pobj.id != "idWorkspace" )  pobj = pobj.parentNode;
	
	
	if ( pobj.pin == "off" ) 
	{
		pobj.pin = "on";
		obj.src = "images/pinon.png";
		//pobj.style.position = "";
		
	} else
	{
		pobj.pin = "off";
		obj.src = "images/pinoff.png";
		//pobj.style.position = "absolute";
	}
}


var nCount = 0;
var nPos = 0;

function SetNormal()
{
	if ( nCount > 0 )
	{
		//idTab.childNodes(nPos).style.backgroundColor="";
		idTab.childNodes(nPos).className = 'tab';
		var title = idTab.childNodes(nPos).title;
		
		if ( title.length > 18 ) 
			title = title.substr( 0, 18 ) + "...";
			
		idTab.childNodes(nPos).innerText= title ;
		
		idContent.childNodes( nPos ).style.display = "none";
		
		//npos, menu_id, menu_cd, title, ltitle, ftitle
		//menucd='"+ menu_cd + "' menuid='"+ menu_id + "' title='"+ sTitle + "' etitle='"+  menu_cd + " " + Title + "' ltitle='"+  menu_cd + " " + lTitle + "' ftitle='"+  menu_cd + " " + fTitle + "' >" + sTitle +
		
		if(idTab.childNodes(nPos).onunactive != '' && idTab.childNodes(nPos).onunactive != undefined){
			idTab.childNodes(nPos).onunactive(nPos, 
											idTab.childNodes(nPos).menuid,
											idTab.childNodes(nPos).menu_cd,
											idTab.childNodes(nPos).etitle,
											idTab.childNodes(nPos).ltitle,
											idTab.childNodes(nPos).ftitle);
		}
		
	}
}

function SetSelect()
{
	if ( nCount > 0 )
	{	
		idTab.childNodes(nPos).className = 'activeTab';
		idTab.childNodes(nPos).innerText = idTab.childNodes(nPos).title ;
		idContent.childNodes( nPos ).style.display = "";
		idContent.childNodes( nPos ).focus();
		
		if(idTab.childNodes(nPos).onactive != '' && idTab.childNodes(nPos).onactive != undefined){
			//npos, menu_id, menu_cd, title, ltitle, ftitle
			//menucd='"+ menu_cd + "' menuid='"+ menu_id + "' title='"+ sTitle + "' etitle='"+  menu_cd + " " + Title + "' ltitle='"+  menu_cd + " " + lTitle + "' ftitle='"+  menu_cd + " " + fTitle + "' >" + sTitle +
			idTab.childNodes(nPos).onactive(nPos, 
											idTab.childNodes(nPos).menuid,
											idTab.childNodes(nPos).menu_cd,
											idTab.childNodes(nPos).etitle,
											idTab.childNodes(nPos).ltitle,
											idTab.childNodes(nPos).ftitle);
		}
		
	}
	CheckScroll();
}
function IsActive(p_tittle)
{
    var idx = FindTab(p_tittle);
    
	if( idx >= 0 )
	{	
		if(idTab.childNodes(idx).className == 'activeTab'){
		    return true;
		}
	}
	return false;
}

function OnPageLoad()
{
	var obj =event.srcElement;
	idTab.childNodes(nPos).onactive = obj.contentWindow.tabActive;
	idTab.childNodes(nPos).onunactive = obj.contentWindow.tabUnActive;
	//onactive='' onunactive=''
	//alert(obj.contentWindow.tabUnActive);
	//npos, menu_id, menu_cd, title, ltitle, ftitle
		//menucd='"+ menu_cd + "' menuid='"+ menu_id + "' title='"+ sTitle + "' etitle='"+  menu_cd + " " + Title + "' ltitle='"+  menu_cd + " " + lTitle + "' ftitle='"+  menu_cd + " " + fTitle + "' >" + sTitle +
		
	if(idTab.childNodes(nPos).onactive != '' && idTab.childNodes(nPos).onactive != undefined){
			idTab.childNodes(nPos).onactive(nPos, 
											idTab.childNodes(nPos).menuid,
											idTab.childNodes(nPos).menu_cd,
											idTab.childNodes(nPos).etitle,
											idTab.childNodes(nPos).ltitle,
											idTab.childNodes(nPos).ftitle);
	}
	for ( var i = 0 ;  i < frames.length ; i ++)
	{
		var doc = frames(i).document;
		if ( doc.location.pathname == obj.contentWindow.location.pathname  ) 
		{ 
			return;
		}
		
	}

}
function NewWindow( url, Title, lTitle, fTitle, menu_id, menu_cd, menu_path )
{  
    if(!Title) return;
    
    _url = url;
    _Title = Title;
    _lTitle = lTitle;
    _fTitle = fTitle;
    _menu_id = menu_id;
	_menu_cd = menu_cd;
	_menu_path = menu_path;
    
    var aTemp = new Array();
	var idx, sTitle;

    if(System.S_Lang == "VIE"){
        sTitle = lTitle;
    }
    else if(System.S_Lang == "KOR"){
        sTitle = fTitle;
    }
    else{
        sTitle = Title;
    }
    
	if (showType == 1){
	
		idx = FindTab(menu_cd + " " + sTitle);
		
		if ((idx != -1) && (idx < idTab.childNodes.length)) {
			SelectTab(idx); 
			var currForm = idContent.childNodes( idx );
	        var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
	        
	        
	        //reload page
	        if(confirm("Do you want to reload this form ?")){
				frm.src = url;
	        }
		} 
		else{
		     if(System.S_Lang == "ENG"){
			    openNewWin(url,  Title, lTitle, fTitle, menu_id,menu_cd, menu_path);
			 }
			 else{
			    var sIdx = url.lastIndexOf("/");
                var eIdx = url.indexOf(".aspx");
                var form_id = url.substr(sIdx + 1,eIdx - sIdx -1);
               
                txtFormID.text = form_id;
                txtLang.text = System.S_Lang;
                datGetFormDictionnary.Call("SELECT");
			 }
		}
	} 
	else{
		if(System.S_Lang == "ENG"){
		    openNewWin(url,  Title, lTitle, fTitle, menu_id,menu_cd, menu_path);
		 }
		 else{
		    var sIdx = url.lastIndexOf("/");
            var eIdx = url.indexOf(".aspx");
            var form_id = url.substr(sIdx + 1,eIdx - sIdx -1);
            
            txtFormID.text = form_id;
            txtLang.text = System.S_Lang;
            datGetFormDictionnary.Call("SELECT");
		 }
	}
}
function LoadDictionaryForPopup(popup_id){
    txtFormID.text = popup_id;
    txtLang.text = System.S_Lang;
    datGetFormDictionnaryPopup.Call("SELECT");
}
function openNewWin(url,  Title, lTitle, fTitle, menu_id,menu_cd, menu_path){
    var sTitle;
    if(System.S_Lang == "VIE"){
        sTitle =  menu_cd + " " + lTitle;
    }
    else if(System.S_Lang == "KOR"){
        sTitle =  menu_cd + " " + fTitle;
    }
    else{
        sTitle =  menu_cd + " " + Title;
    }
    
	
	
	var i = url.lastIndexOf( "/" );
	var eIdx = url.indexOf(".aspx");
	var short_url = url.substr(0,eIdx+5);
	
	SetNormal();
	
	idTab.insertAdjacentHTML("afterBegin" , "<span onmouseout='outTab(this)' onmouseover='overTab(this)' onclick='ClickTab()' onactive='' onunactive='' menucd='"+ menu_cd + "' menuid='"+ menu_id + "' title='"+ sTitle + "' etitle='"+  menu_cd + " " + Title + "' ltitle='"+  menu_cd + " " + lTitle + "' ftitle='"+  menu_cd + " " + fTitle + "' >" + sTitle + "</span>" );
	
	idContent.insertAdjacentHTML("afterBegin" , 
	'<table style="' + Gb_TableStyle +'"  height="100%" border=' + Gb_TableBorder +' cellspacing=0 cellpadding=0 >' +
	'<tr>	' +
	'	<td style="' + Gb_TdStyle1 +'">'+
	'		<table border=0 width="100%" ><tr>'+
	'			<td  align="left" width=2%>' +
	'				<img src="images/iconapplication.gif" title='+ url +' align="absMiddle">' +
	'			</td>' +
	'			<td  id="idTitle" width="70%" style="' + Gb_TdStyle2 + '" align="left">['+ menu_path +'][Menu: '+ menu_id +']</td>' +
	'			<td  id="idTitle" width="21%" style="' + Gb_TdStyle2 + '" align="right"><b>Welcome ['+ System.S_UserName +']</td>' +
	'			<td align="right" width=7%><nobr>' +
	'				<img style="cursor:hand" src="images/dictionary.png" alt="open dictionary" align="absMiddle" onclick="ExecuteFile()">' +
	'				<img style="cursor:hand" alt="help" src="images/iconpopup.png" align="absMiddle" onclick="openUserGuide(\''+ url + '\')">' +	
	'				<img src="images/iconminimize.png" alt="next window" align="absMiddle" onclick="NextWindow()">' +
	'				<img src="images/iconexit.png" alt="close window" align="absMiddle" onclick="DeleteWindow()">' +
	'				</nobr>' +
	'			</td>' +
	'		</tr></table>'+
	'	</td>' +
	'</tr>' +
	'<tr>' +
	'	<td  width="100%" height="100%" border=0>'+
	'		<iframe id="frmContent" src="' + url +'"  style="padding:0 0 0 0;' + Gb_FrameStyle +'" frameborder=' + Gb_FrameBorder +'  onload="OnPageLoad()">	</iframe>'+
	'	</td>'+
	'</tr>'+
	'</table>	'
	);
	
	nCount ++;
	nPos = 0;
	
	SetSelect();
	
	//alert(System.Menu.delegateTab);
		for(var k=0; k < System.Menu.delegateTab.length; k++){
			if(System.Menu.delegateTab[k] != undefined){
				System.Menu.delegateTab[k](nPos,sTitle);
			}
		}
}
//find tab by title
function FindTab( tlt ) {
	var pobj = idTab;
	var i = 0;
	while ( i< idTab.childNodes.length) {
		obj = idTab.childNodes(i);
		if (obj.tagName == "SPAN" ) {
			if ( obj.title == tlt) {
				return i;
			}
		}
		i++;
	}
	return -1;
}

//select tab by it's index
function SelectTab(idx) {
	if ( idx != -1  && idx != nPos ){
		SetNormal();
		nPos = idx;
		SetSelect();
	}
}

function ClickTab()
{
	
	var obj = event.srcElement;
	var pobj;
	while ( obj.tagName != "SPAN" ) obj = obj.parentNode;
	
	pobj = obj.parentNode;
	
	var pos=-1;
	for ( var i = 0 ;  i < pobj.childNodes.length ; i++)
	{
		if ( pobj.childNodes(i) == obj )
		{
			pos = i;
			break;
			
		}
	}
	
	if ( pos != -1  && pos != nPos )
	{
		SetNormal();
		
		nPos = pos;
		
		SetSelect();
		
		var tabTilte;
    
        if(System.S_Lang == "ENG"){
            tabTilte=idTab.childNodes(nPos).etitle;
        }
        else if(System.S_Lang == "VIE"){
            tabTilte=idTab.childNodes(nPos).ltitle;
        }
        else{
            tabTilte=idTab.childNodes(nPos).ftitle;
        }
        _Title = idTab.childNodes(nPos).etitle;
        _lTitle = idTab.childNodes(nPos).ltitle;
        _fTitle = idTab.childNodes(nPos).ftitle;
        //alert(idTab.childNodes(nPos).title+":"+nPos+":"+tabTilte);
		
		//alert(System.Menu.delegateTab);
		for(var k=0; k < System.Menu.delegateTab.length; k++){
			if(System.Menu.delegateTab[k] != undefined){
				System.Menu.delegateTab[k](pos,tabTilte);
			}
		}
		
		
        if(idTab.childNodes(nPos).title != tabTilte){
            UpdateLanguageToForm();
        }
	}
}
function IsActive(p_tittle)
{
    var idx = FindTab(p_tittle);
    
    if( idx >= 0 )
    { 
        if(idTab.childNodes(idx).className == 'activeTab'){
            return true;
        }
    }
    return false;
}

function overTab( obj )
{
	var pobj;
	while ( obj.tagName != "SPAN" ) obj = obj.parentNode;
	
	pobj = obj.parentNode;
	
	var pos=-1;
	for ( var i = 0 ;  i < pobj.childNodes.length ; i++)
	{
		if ( pobj.childNodes(i) == obj )
		{
			pos = i;
			break;
			
		}
	}
	
	if ( pos != nPos )
	{
		obj.className = 'overTab';
	}
}

function outTab( obj ){
	var pobj;
	while ( obj.tagName != "SPAN" ) obj = obj.parentNode;
	
	pobj = obj.parentNode;
	
	var pos=-1;
	for ( var i = 0 ;  i < pobj.childNodes.length ; i++)
	{
		if ( pobj.childNodes(i) == obj )
		{
			pos = i;
			break;
			
		}
	}
	
	if ( pos != nPos )
	{
			obj.className = 'tab';	
	}
}
function ExecuteFile() {
   
   
	var currForm = idContent.childNodes( nPos );
	var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
	var doc = frm;
	var url = currForm.childNodes(0).childNodes(0).childNodes(0).childNodes(0).childNodes(0).childNodes(0).childNodes(1).innerHTML;
	var sIdx = url.lastIndexOf(":");
    var form_id = url.substr(sIdx + 2,url.length - sIdx - 3);
    if(form_id == "undefined"){
        alert("This form is error cannot make dictionary!");return false;
    }
    var result = System.GetDataLanguage(doc.contentWindow.document);
    if (result == ""){
        alert("No data make dictionary!");return false;
    }/*
    if(lang != "ENG"){
        alert("Please choose English Language!");return false;
    }*/
    if ("<%=Session["CODEADMIN_YN"]%>" != "Y") {
        alert("Only Admin System can used this function!"); return false;
    }
    var fpath = System.RootURL + "/system/sde/ab/DictionnaryAuto.aspx?form_id="+form_id + "&type_dic=form";    
    System.OpenModal(fpath , 900 , 600 , 'resizable:yes;status:yes;scroll:no;');
    //window.open(fpath);
}
function ExecuteFile2()
{
// Instantiate the Shell object and invoke its execute method.
var oShell = new ActiveXObject("Shell.Application");
var commandtoRun = "D:\\WebProject\\MaterialInOut\\bin\\Debug\\MaterialInOut.exe";
// Invoke the execute method.
  oShell.ShellExecute(commandtoRun, "", "", "open", "1");
}
function openUserGuide( str ) {
    var x = Math.round((screen.availWidth - 600) / 2);
 	var y = Math.round((screen.availHeight - 600) / 2);
 
	var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
			   "scrollbars=yes,resizable=yes,copyhistory=no,width="+850+",height="+650 +
			   "lef="+ x +",top=" + y;
	if (Trim(str) != "") {
	    str=str.replace("form","manual");
	    
		window.open("Manual.aspx?url="+ str, 'ManualWin', features);
	}
}

function NextWindow()
{
	if ( nCount > 1 )
	{
		SetNormal();
		
		nPos++;
		
		if ( nPos == nCount ) nPos = 0;
		
		SetSelect();
		
	}
}

function DeleteWindow()
{
   
   if(window.frames[nPos+1].canClose) // 2 iframe menu,workspace
	{
	    if(!window.frames[nPos+1].canClose())  //Thai
	    {
		       return ; // user cancel closing action
	    }
	}

	if ( nCount > 0 )
	{
		nCount --;
		
		idTab.removeChild( idTab.childNodes(nPos) );
		idContent.removeChild( idContent.childNodes( nPos ));
		
		nPos = 0
	
		SetSelect();
	}
	
}


var nScrollDelta = 0;
var nScrollID = 0;

function fnScrollTick()
{
	idTabScroll.scrollLeft += nScrollDelta;
	CheckScroll();
}

function Scroll( d )
{

	nScrollDelta = d*10;

	if ( nScrollID != 0 )
		MenuStop();
	nScrollID = setInterval( fnScrollTick , 50 );

}

function ScrollStop()
{
	if ( nScrollID != 0 )
	{
		clearInterval( nScrollID );
		nScrollID = 0;
	}
}

function CheckScroll()
{
	if ( idTabScroll.scrollLeft == 0 )
		idScrollLeft.style.display = "none";	
	else
		idScrollLeft.style.display = "";
		
	if ( idTabScroll.offsetWidth < idTabScroll.scrollWidth -idTabScroll.scrollLeft )
		idScrollRight.style.display = "";
	else
		idScrollRight.style.display = "none";
}
var showType;

function init(){
	var obj = document.all("imgType");	
	showType = obj.status;
	var debug_yn = "<%=Session["Debug_YN"]%>";
	var obj = top.document.getElementById("imgDebug");
	if(debug_yn == "Y")
	{
	   obj.style.display="";
	}
	else
	{
	    obj.style.display="none";
	}
	lstLang.SetDataText("<%=Session["SESSION_LANG"]%>");
	System.S_Lang = lstLang.GetData();
	frmLeftMenu.document.location.href = "../system/menu/menu.aspx?lang="+lstLang.GetData();
}

function ShowTypeClick(obj) {
	if(obj.status == 0){
		obj.src='images/pinon.png';
		obj.status = 1;
	} else {
		obj.src='images/pinoff.png';
		obj.status = 0;
	}
	showType = obj.status;
}
function PinOver(obj) {
	if(obj.status == 0){
		obj.src='images/pinoff_over.png';
	} else {
		obj.src='images/pinon_over.png';
	}
}
function PinOut(obj) {
	if(obj.status == 0){
		obj.src='images/pinoff.png';
	} else {
		obj.src='images/pinon.png';
	}
}
function OnLangChange(){
    System.S_Lang = lstLang.GetData();
    frmLeftMenu.document.location.href = "../system/menu/menu.aspx?lang="+lstLang.GetData();
}
function UpdateLanguageToForm(){
    if(nCount > 0){
        if(!confirm("Do you want to update language for this form. \nIf you click OK. your current data which has not saved yet will be lose.")){
            return;
        }
    }
    else{
        return;
    }
    
    var tabTilte;
    
    if(System.S_Lang == "ENG"){
        tabTilte=idTab.childNodes(nPos).etitle;
    }
    else if(System.S_Lang == "VIE"){
        tabTilte=idTab.childNodes(nPos).ltitle;
    }
    else{
        tabTilte=idTab.childNodes(nPos).ftitle;
    }
    
    idTab.childNodes(nPos).innerText = tabTilte;
	idTab.childNodes(nPos).title = tabTilte;	
	
	gReload = true;
	LoadFormDictionnary();
	
}
function ReloadForm(){
    
    if(nPos > -1 && nCount > 0){
        var url = new String();
        var currForm = idContent.childNodes( nPos );
        var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
        url = frm.src;
       
        //remove all querystring when reload form
        //url = url.substr(0,url.indexOf(".")) + ".aspx";
        frm.src = url;
    }
}    
function LoadFormDictionnary(){
    var currForm = idContent.childNodes( nPos );
	var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
	var url = frm.src;
	var sIdx = url.lastIndexOf("/");
    var eIdx = url.indexOf(".aspx");
    var form_id = url.substr(sIdx + 1,eIdx - sIdx -1);
    
    txtFormID.text = form_id;
    txtLang.text = System.S_Lang;
    datGetFormDictionnary.Call("SELECT");
}
function OnDataReceive(p_oData){
    if(p_oData.id == "datGetFormDictionnary"){
        BindDictionaryToArray(event.array);
    }
    else if(p_oData.id == "datGetFormDictionnaryPopup"){
        BindDictionaryToArrayPopup(event.array);
    }
}
function BindDictionaryToArrayPopup(arr){
    System.S_ArrFormDict = new Array();
    
    for(var i=0; i < arr.length ; i++ ){
       
       var tmp=new Array();
       
       tmp[tmp.length] = arr[i][0];//eng
       tmp[tmp.length] =  arr[i][1];//user language
       
       System.S_ArrFormDict[System.S_ArrFormDict.length] = tmp;
    }
}    
function BindDictionaryToArray(arr){
    System.S_ArrFormDict = new Array();
    
    for(var i=0; i < arr.length ; i++ ){
       
       var tmp=new Array();
       
       tmp[tmp.length] = arr[i][0];//eng
       tmp[tmp.length] = arr[i][1];//user language
       
       System.S_ArrFormDict[System.S_ArrFormDict.length] = tmp;
    }
    if(gReload == false){
        openNewWin(_url,  _Title, _lTitle, _fTitle, _menu_id, _menu_path);
    }
    else{
        var currForm = idContent.childNodes( nPos );
	    var frm = currForm.childNodes(0).childNodes(1).childNodes(0).childNodes(0);
	    //reload page
	    frm.src = frm.src;
	    gReload = false;
	    
    }
}

function GetMenuID(){
	var id = System.Menu.idContent.childNodes(System.Menu.nPos).childNodes(0).all("idTitle")[0].innerHTML.toString().split(":")[1];
	return id.substring(0,id.length-1).replace(/ /g,'');
}

function getArrErr(obj){
	var str = eval(obj).errmsg.toString();
	var arr= [	str.split('|')[0].split(":")[0].split("-")[1].replace(/^\s+|\s+$/gm,''), 
				str.split('|')[0].split(":")[1].replace(/^\s+|\s+$/gm,'')];
	return arr;
}

function OnHelp2(){
	window.open('about:blank', 'SupportCenter');
    document.getElementById('theForm').submit();
}
</script>

<html>
<body onLoad="init()" style="padding: 0 0 0 0; margin: 0 0 0 0; background-color: #FFFFFF; overflow: hidden;
    background-image: url(images/menutop/menu_bgr.gif); background-repeat: repeat-x;" >
    <gw:data id="datGetFormDictionnary" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="array" parameter="0,1" function="sp_es_sel_form_dictionnary" > 
                <input bind="noneed" >
                    <input bind="txtFormID" />  
                    <input bind="txtLang" /> 
                </input> 
                <output bind="noneed" /> 
            </dso> 
        </xml> 
 </gw:data>
 <gw:data id="datGetFormDictionnaryPopup" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="array" parameter="0,1" function="sp_es_sel_dictionnary_popup" > 
                <input bind="noneed" >
                    <input bind="txtFormID" />  
                    <input bind="txtLang" /> 
                </input> 
                <output bind="noneed" /> 
            </dso> 
        </xml> 
 </gw:data>
	<form id='theForm' method='post' target='SupportCenter' action='http://support.vinagenuwin.com:8080/vms/support/forward_url.gw'>
		<input type='hidden' name='p1' value='VCL022'>
		<input type='hidden' name='p0' value='frm/vm/rp/vmrp00070_pop'>
	</form>
    <table border="0" width="100%" cellpadding="0" cellspacing="0" style="height:100%" >
        <tr valign="top" style="height:40" >
            <td>
                <table width="100%">
                    <tr style="height:40">
                        <td width="10%">
                           <div >
                              <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
                             codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0"
                             width="134" height="40" >
                                <param name=movie value="images/swf/logotreasure.swf">
                                <param name=quality value=high>
                                <param name=wmode value=transparent>
                                <param name=bgcolor value=#FFFFFF>
                                <param name="wmode" value="transparent"> 
                                <embed src="../images/swf/logotreasure.swf" quality="high" wmode="transparent" bgcolor=#FFFFFF  width="134" height="40" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer">
                                 </embed> 
                              </object>
                            </div>
                        </td>
                        <td width="54%" align="center">&nbsp; </td>
                        <td width="10%" align="center"><img src="images/menutop/help.gif" width="120" height="30" style="cursor:pointer; background-image:none; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/menutop/help.gif', sizingMethod='scale');" alt="Help" onclick="OnHelp2();" /></td>
                        <td width="2%" align="center">&nbsp; </td>
                        <td width="5%" align="center"><img src="images/menutop/dot_transparent.gif" width="70" height="26" style="cursor:pointer; background-image:none; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/menutop/log-out.png', sizingMethod='scale');" alt="Log out" onclick="System.AppLogout()" /></td>
                        <td width="5%"><img src="images/menutop/dot_transparent.gif" width="63" height="26" style="cursor:pointer; background-image:none; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='images/menutop/iconRefresh.png', sizingMethod='scale');" alt="Refresh the current form" style="cursor:pointer; filter: progid:DXImageTransform.Microsoft.AlphaImageLoader(src='iconRefresh.png', sizingMethod='scale';" onClick="ReloadForm()" /></td>
                        <td width="11%">
                            <gw:list id="lstLang" styles="width:100%" onchange="OnLangChange()">
                                <data>Data|ENG|English|VIE|Vietnamese|KOR|Korean</data>
                            </gw:list>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr valign="top" style="height:99%">
            <td>
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:100%">
                    <tr valign="top" style="height:100%">
                        <td>
                            <table pin="on" id="idWorkspace" style="width: 250;border: 2 outset lightgray;"
                                border="0" cellspacing="0" cellpadding="0" style="height:100%">
                                <tr style="height:1%">
                                    <td style="background-image:url(menu/images/menuHeaderBackground.gif)">
                                        <table border="0" width="100%">
                                            <tr>
                                                <td width="99%">Menu</td>
                                                <td width="1%" align="right" >
                                                    <img src="menu/images/iconHideAppMenu.png"  onmouseover="this.src='menu/images/iconHideAppMenuOver.png'" onmouseout="this.src='menu/images/iconHideAppMenu.png'" style="cursor:pointer;" alt="Hide the application menu" onclick="HideAppMenu()">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr style="height:99%">
                                    <td>
                                        <iframe id="frmLeftMenu" style="border: 1 outset #eeeeee; width: 100%; height: 100%; overflow:auto"  frameborder="0"></iframe>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td width="100%">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
                                <tr valign="top" style="height:3%">
                                    <td> 
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                        <tr>
                                                            <td width="3%">
                                                               <table width="100%" cellpadding="0" cellspacing="0" border="0">
                                                                    <tr>
                                                                        <td><img  src="menu/images/iconShowAppMenu.png" width="31" height="24" onmouseover="this.src='menu/images/iconShowAppMenuOver.png';" onmouseout="this.src='menu/images/iconShowAppMenu.png';" id="imgShowMenu" style="display:none;cursor:hand" alt="Show the application menu" onClick="ShowMenu()"/></td>
                                                                        <td><img  src="images/pinon.png" width="31" height="24" onmouseover="PinOver(this);" onmouseout="PinOut(this);" id="imgType" status="1" style="cursor: hand" onClick="ShowTypeClick(this);" title="dock" /></td>
                                                                    </tr>
                                                               </table>
                                                            </td>
                                                            <td width="97%">
                                                                <div class="frmDiv">
                                                                    <nobr>
						                                                <div id="idScrollLeft" onmouseout="ScrollStop()" onmouseover="Scroll(-1)" style="border:1 solid #eeeeee;filter:alpha(opacity=85);background-color:blue; color:white;display:none;width:5;cursor:hand;position:absolute;text-align:center;z-index:10;" >
							                                               <
						                                                </div>			
						                                                <span id="idTabScroll" style="width:100%;overflow:hidden; padding: 0 0 0 10 ;width: expression( offsetParent.offsetWidth - 30 )">
						                                                <b><nobr id="idTab"  style="font-size:9pt;  font-weight ;padding-left:10" ></nobr></b>
						                                                </span>
						                                                <div id="idScrollRight" onmouseout="ScrollStop()" onmouseover="Scroll(1)" style="border:1 solid #eeeeee;filter:alpha(opacity=85);background-color:blue; ;color: white; font-weight:bold; display:none;width:5;cursor:hand;position:absolute;text-align:left:-10;center;z-index:10;" >
							                                             >
						                                                </div>			
					                                                </nobr>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr valign="top" style="height:97%">
                                    <td>
                                        <div  style="border:1" id="idContent"></div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    
    <gw:textbox id="txtFormID" styles="display:none" />
    <gw:textbox id="txtLang" styles="display:none" />
    
</body>
</html>
