<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Mail Center</title>
</head>
<script>
var ajax_test;
var arErr = [""];
var COL_Status          = 0,
    COL_Company_Name    = 1,
    COL_Tax_Code        = 2,
    COL_Department      = 3,
    COL_Staff_Code      = 4,
    COL_Staff_Name      = 5,
    COL_E_Mail          = 6,
    COL_Name_Mail       = 7,
    COL_Domain_Mail     = 8,
    COL_Sync            = 9,
    COL_PK              = 10;

function BodyInit(){	
    On_Refesh();   
}

function On_Select(){
    for(var idx = 1; idx < gridMail.rows; idx++){
        gridMail.SetGridData(idx, COL_Status, -1);
    }
}

function On_DeSelect(){
    for(var idx = 1; idx < gridMail.rows; idx++){
        gridMail.SetGridText(idx, COL_Status, 0);
    }
}

function On_Refesh(){
    lbClient.text   = '0';
    lbServer.text   = '0';
    lbUpdated.text  = '0';
    lbRequire.text  = '0';
    dsoMail.Call('SELECT');
}

function On_Search(){
    dsoMail.Call('SELECT');
}

function On_Check(type){
    if(type != 'check' || type != 'info'){
        if(!confirm('Are you sure to ' + type + '.')){
            return false;
        }
    }

    if(type == 'sync')
        On_Select();     

    lbUpdated.text  = '0';
    lbRequire.text  = '0';
    for(var idx = 1; idx < gridMail.rows; idx++){
        if(gridMail.GetGridData(idx, COL_Status) == -1) {lbRequire.text = parseInt(lbRequire.text) + 1;}
    }
    
    if(txtNameMail.text.length == 0 && type == 'check'){alert('Please input name mail into "Name Email".');return false;}
    
    if(lbRequire.text == '0' && type != 'check'){alert('Please select staff data for send server.');return false;}
    
    if(type == 'info' && lbRequire.text != '1' && type != 'check'){alert('Only select one staff.');return false;}
    
    
    btnSearch.SetEnable(false);
    btnSelect.SetEnable(false);
    btnDeSelect.SetEnable(false);
    btnRefesh.SetEnable(false);
    btnSend.SetEnable(false);
    btnUpdate.SetEnable(false);
    btnDelete.SetEnable(false);
    btnSync.SetEnable(false);
    btnInfo.SetEnable(false);
    btnCheck.SetEnable(false);
    System.ShowProgress();
    On_Send(type);
}

function On_Send(type){
    var cur = 0;

    for(var idx = 1; idx < gridMail.rows; idx++){
        if(gridMail.GetGridData(idx, COL_Status) == -1) {cur = idx; idx = gridMail.rows;}
    }

    var url  = "http://www.poscovietnam.vn/Services.ashx?stp=GRID&str=TPCVN_UPD_MAIL&sid=" + Math.random();
    url     += "&p0=" + type;
    
    if (type == 'sync')
    url     += "&p1=1";
    else 
    url     += "&p1=0";
    
    url     += "&p2=" + encodeURIComponent(gridMail.GetGridData(cur, COL_E_Mail));
    
    if(type == 'check')
    url     += "&p3=" + encodeURIComponent(txtNameMail.text);
    else
    url     += "&p3=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Name_Mail));
    
    url     += "&p4=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Domain_Mail));
    url     += "&p5=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Tax_Code));
    url     += "&p6=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Company_Name));
    url     += "&p7=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Staff_Name));
    url     += "&p8=" + encodeURIComponent(gridMail.GetGridData(cur, COL_Staff_Code));
    url     += '&p9=' + "<%=session("User_ID")%>";
    url     += "&p10=" + cur;
    
    ajax_test = GetXmlHttpRequest(On_Result);
    ajax_test.open("GET", url , true);
    ajax_test.send(null);/**/
}

function On_Result(){
	if(GetRequestState(ajax_test)){
	    try{
	        var xml, rows, cols, cell, status, message, type;
	        
            xml= StringtoXML(ajax_test.responseText);
            rows = xml.getElementsByTagName("rows");
	        if(rows.length > 0){
    	        if(rows.length == 1){
    	            cols = xml.getElementsByTagName("cols");
    	            if(cols.length > 0){
    	                cell    = decodeURIComponent(cols[0].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " "));
    	                status  = decodeURIComponent(cols[1].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " "));
    	                type    = decodeURIComponent(cols[2].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " "));
    	                
    	                lbUpdated.text = parseInt(lbUpdated.text) + 1;
    	                
    	                if(type != 'check')
    	                    gridMail.SetGridText(parseInt(cell), COL_Status, 0);
    	                
    	                switch(status){
    	                    case 'err0001':
    	                        arErr.push('err0001 : Account "' + gridMail.GetGridData(parseInt(cell), COL_Staff_Code) + ' - ' + gridMail.GetGridData(parseInt(cell), COL_Name_Mail) + '" email exist.');
    	                    break;
							case 'err0003':
    	                        arErr.push('err0003 : Account "' + gridMail.GetGridData(parseInt(cell), COL_Staff_Code) + ' - ' + gridMail.GetGridData(parseInt(cell), COL_Name_Mail) + '" company exist.');
    	                    break;
    	                    case 'err0002':
    	                        arErr.push('err0002 : Account "' + gridMail.GetGridData(parseInt(cell), COL_Staff_Code) + ' - ' + gridMail.GetGridData(parseInt(cell), COL_Name_Mail) + '" email not register to server.');
    	                        gridMail.SetGridText(parseInt(cell), COL_Sync, 'N'); 
    	                    break;
							case 'err0004':
    	                        arErr.push('err0004 : Account "' + gridMail.GetGridData(parseInt(cell), COL_Staff_Code) + ' - ' + gridMail.GetGridData(parseInt(cell), COL_Name_Mail) + '" company not register to server.');
    	                        gridMail.SetGridText(parseInt(cell), COL_Sync, 'N'); 
    	                    break;
    	                    case 'check':
    	                        arErr.push(cols[3].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " "));
    	                    break;
    	                    default:
    	                        if(type != 'info')gridMail.SetGridText(parseInt(cell), COL_Sync, 'Y'); 
    	                        if(type == 'delete')    gridMail.SetGridText(parseInt(cell), COL_Sync, 'N'); 
    	                        if(type == 'sync')      type = 'insert'; 
    	                        if(type == 'info'){
    	                            arErr.push('Staff Code : ' + decodeURIComponent(cols[3].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " ")) + '\r\n');
    	                            arErr.push('Staff Name : ' + gridMail.GetGridData(cell, COL_Staff_Name) + '\r\n');
    	                            arErr.push('E-mail : '     + decodeURIComponent(cols[5].firstChild.nodeValue.replace(/!!/g,'&').toLowerCase().replace(/\+/g, " ")) + '\r\n');
    	                        }
    	                        lbServer.text = status;
    	                    break;
    	                }
    	                
    	                if( parseInt(lbRequire.text) > parseInt(lbUpdated.text) && type != 'check') On_Send(type);
    	                else {
    	                    message = "Finish";
    	                
    	                    btnSearch.SetEnable(true);
                            btnSelect.SetEnable(true);
                            btnDeSelect.SetEnable(true);
                            btnRefesh.SetEnable(true);
                            btnSend.SetEnable(true);
                            btnUpdate.SetEnable(true);
                            btnDelete.SetEnable(true);
                            btnSync.SetEnable(true);
                            btnInfo.SetEnable(true);
                            btnCheck.SetEnable(true);
                            System.HideProgress();
                            if (arErr.length > 1){
                                message = "";
                                for(var idx = 0; idx < arErr.length; idx ++)
                                    message += arErr[idx] + '\r\n';
                            }
                            alert(message);
                            arErr = [""];
                            
                            if(type != 'check')
                                dsoMail.Call();
    	                }
    	            }
    	        }
	        }
        }
        catch(err){
            alert(err);
        }
	}
}

function StringtoXML(text){
    if (window.ActiveXObject){
      var doc=new ActiveXObject('Microsoft.XMLDOM');
      doc.async='false';
      doc.loadXML(text);
    } else {
      var parser=new DOMParser();
      var doc=parser.parseFromString(text,'text/xml');
    }
    return doc;
}

function OnDataReceive(obj){
    if(obj.id == "dsoMail")
        if (gridMail.rows > 1){
	        lbClient.text = gridMail.rows - 1;
	        for(var idx = 1; idx < gridMail.rows; idx++){
                if(gridMail.GetGridData(idx, COL_Sync) == 'Y') {gridMail.SetCellBgColor(idx, COL_Status, idx, COL_PK,0xA9EBD7);}
            }
        }
}
</script>
<body>
    <gw:data id="dsoMail" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="9,10" function="HR_SEL_10010072" procedure="HR_UPD_10010072">  
                <input bind="gridMail" >
                    <input bind="txtEmpID" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstStatus" />
                    <input bind="lstEmail" />
                </input> 
                <output bind="gridMail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table cellpadding="0" cellspacing="0" style="width:100%;height:90%;top:10px;position:absolute">
        <tr>
            <td align="center">
                <table cellpadding="0" cellspacing="0" style="width:90%;height:70px;" border="0">
                    <tr>
                        <td valign="top" style="width:50%;padding-right:5px;">
                            <fieldset>
                                <legend>Local</legend>
                                <table cellpadding="0" cellspacing="0" style="width:100%;" border="0">
                                    <tr style="height:30px;">
                                        <td style="width:100%" align="right">Join DT</td>
                                        <td align="right"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                                        <td style="padding:0 5 0 5">~</td>
                                        <td style="padding:0 0 0 5"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                                        <td align="right" style="color: blue;padding:0 5 0 5"><gw:icon id="btnSearch" img="in" text="Search" onclick="On_Search();" /></td>
                                        <td align="right" style="color: blue;padding:0 5 0 5"><gw:icon id="btnSelect" img="in" text="Select All" onclick="On_Select();" /></td>
                                        <td align="right" style="color: blue;padding:0 5 0 5"><gw:icon id="btnDeSelect" img="in" text="Clear All" onclick="On_DeSelect();" /></td>
                                        <td align="right" style="color: blue;padding:0 5 0 5"><gw:icon id="btnRefesh" img="in" text="Refesh" onclick="On_Refesh();" /></td>                        
                                    </tr>
                                    <tr style="height:30px;">
                                        <td colspan="8" align="center">
                                            <table cellpadding="0" cellspacing="0" border="0">
                                                <tr>
                                                    <td align="right" style="padding:0 5 0 5">Employ ID</td>
                                                    <td align="right" style="padding:0 5 0 5"><gw:textbox id="txtEmpID" style="width:100px" onenterkey="On_Search()" /></td>
                                                    <td align="right" style="padding:0 5 0 5">Status</td>
                                                    <td align="right" style="padding:0 5 0 5">
                                                        <gw:list id="lstStatus" value='A' maxlen = "100" styles='width:100px'><data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by seq" )%>|ALL|Select All</data></gw:list>
                                                    </td>
                                                    <td align="right" style="padding:0 5 0 5">Email Status</td>
                                                    <td align="right" style="padding:0 5 0 5">
                                                        <gw:list id="lstEmail" value='ALL' maxlen = "100" styles='width:100px'><data>DATA|N|Not Register|Y|Register|ALL|Select All</data></gw:list>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td valign="top" style="width:50%;padding-left:5px;">
                            <fieldset>
                                <legend>Server Mail Center</legend>
                                <table cellpadding="0" cellspacing="0" style="width:100%;" border="0">
                                    <tr style="height:30px;">
                                        <td style=""></td>
                                        <td style="padding:0 5 0 5;white-space:nowrap" align="right">Name Email</td>
                                        <td style="padding:0 5 0 5;" align="right"><gw:textbox id="txtNameMail" style="width:120px"/></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5"><gw:icon id="btnCheck" img="in" text="Check" onclick="On_Check('check');" /></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5"><gw:icon id="btnInfo" img="in" text="Get Info" onclick="On_Check('info');" /></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5;"><gw:icon id="btnSend" img="in" text="Insert" onclick="On_Check('insert');" /></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5;"><gw:icon id="btnUpdate" img="in" text="Update" onclick="On_Check('update');" /></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5;"><gw:icon id="btnDelete" img="in" text="Delete" onclick="On_Check('delete');" /></td>
                                        <td align="center" style="color: blue;padding:0 5 0 5;"><gw:icon id="btnSync" img="in" text="Sync..." onclick="On_Check('sync');" /></td>
                                    </tr>
                                    <tr style="height:30px;">
                                        <td colspan="9" align="center">
                                            <table cellpadding="0" cellspacing="0" style="width:100%;" border="0">
                                                <tr>
                                                    <td style="width:30%"></td>
                                                    <td align="right" style="color: blue;padding:0 5 0 5">Require : </td>
                                                    <td align="center" style="width:50px;padding:0 5 0 5"><gw:label id="lbRequire" styles="color: red; width: 100%; font-weight:bold"></gw:label></td>
                                                    <td align="right" style="color: blue;padding:0 5 0 5">Sended : </td>
                                                    <td align="center" style="width:50px;padding:0 5 0 5"><gw:label id="lbUpdated" styles="color: red; width: 100%; font-weight:bold"></gw:label></td>
                                                    <td align="right" style="width:50px;color: blue;padding:0 5 0 5">Client : </td>
                                                    <td align="center" style="width:50px;padding:0 5 0 5"><gw:label id="lbClient" styles="color: red; width: 100%; font-weight:bold"></gw:label></td>
                                                    <td align="right" style="width:50px;color: blue;padding:0 5 0 5">Server : </td>
                                                    <td align="center" style="width:50px;padding:0 5 0 5"><gw:label id="lbServer" styles="color: red; width: 100%; font-weight:bold"></gw:label></td>
                                                    <td style="width:30%"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>        
                            </fieldset>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="width:90%;height:100%" border="0">
                    <tr>
                        <td valign="top" colspan="20" style="padding-top:10px;height:100%">
                            <gw:grid   
				                id="gridMail"  
				                header="Select|Company Name|Tax Code|Department|Staff Code|Staff Name|E-Mail|Name Mail|Domain Mail|_Sync|_Pk_staff"   
				                format="3|0|0|0|0|0|0|0|0|0|0"  
				                aligns="1|0|1|0|1|0|0|0|0|0|0"  
				                defaults="|||||||||||"  
				                editcol="0|0|0|0|0|0|0|0|0|0|0"  
				                widths="700|3000|1500|3000|1500|2000|2000|1500|1000|100|100"  
				                styles="width:100%; height:85% "   
				                sorting="T"   
				                />
                        </td>
                    </tr>
                </table>
            </td>  
        </tr>
    </table>
</body>
</html>