<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var flag_pk=0;
function BodyInit()
{
	OnToggle();
	grdList.GetGridControl().FrozenCols =5;
	datVisitorHistory.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datVisitorHistory")
    {
        lblRecord.text=grdList.rows-1 + " rec(s).";
        auto_resize_column(grdList,0,grdList.cols-1,0);
        
    }    
    if(obj.id=="datVisitorDetail")
            flag_pk=txtMaster_PK.text;//luu pk vua search 
}

function OnSearchVisitorData()
{
	datVisitorHistory.Call("SELECT");
}

function ShowGateEnvent()
{
	if(grdList.rows <= 1)
	{
		return;
	}
	else
	{
		var param01 = grdList.GetGridData( grdList.row, 0 ) + " : " + grdList.GetGridData( grdList.row, 7 );
		var fpath = System.RootURL + "/form/ch/ov/CommonList01.aspx?popTitle=" + "List of Scan Event" 
									+ "&dsqlid=HR.SP_SEL_VISITOR_ESCAN"
									+ "&header=_PK|Scan Event|Machine ID|Description"
									+ "&size=0|2500|2000|1000"
									+ "&param01=" + param01;
		//alert(fpath);
		var object = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
	}
	
}

/*#######################################################################################*/
function OnDataError(obj)
{
	AlertDBError(obj.errmsg);
}

/*#######################################################################################*/
function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------
function OnToggle()
{
    
    if(imgArrow.status == "expand")
    {
        tr2.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/iconmaximize.gif";
        
        tr1.style.height="94%";
        tr2.style.height="0%";
        
    }
    else
    {
        tr2.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/close_popup.gif";
       
        tr1.style.height="64%";
        tr2.style.height="30%";
        //alert(txtMaster_PK.text)
      //  alert(flag_pk)
        if (grdList.row>0)
        {
            if(flag_pk!=txtMaster_PK.text)
            {
                
                txtMaster_PK.text=grdList.GetGridData(grdList.row,0);
                datVisitorDetail.Call("SELECT");
            }    
        }
        
    }
    
}

function ShowDetail()
{
    txtMaster_PK.text=grdList.GetGridData(grdList.row,0);
    if((flag_pk!=txtMaster_PK.text)||(flag_pk==0))
    {
        if (imgArrow.status=="expand")
        {
           //alert(txtMaster_PK.text);
           datVisitorDetail.Call("SELECT");
        }
    }    
    
    
}
function OnShowVisCompanyPopup()
{
	
		var fpath = System.RootURL + "/form/ch/ov/chov00030.aspx?showType=" + "popup"
		var obj = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes'); 
		if (obj!=null)
        {
            lstCompany_In.SetDataText(obj[0]);
            
        }
		
	
}
function OnReport()
{
   url =System.RootURL + '/reports/ch/ov/rpt_visitor_history.aspx?L_CHECKIN_DT_FR=' + datWorkDateFr.value + '&L_CHECKIN_DT_TO=' + datWorkDateTo.value + '&L_VIS_COMPANY='+lstCompany_In.value + '&L_SEARCH_INFO=' + txtSearchInfo.text;
    window.open(url);                    
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Visitor In-Out Management</title>
</head>
<body>

<gw:data id="datVisitorHistory" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6" function="HR.SP_SEL_VISITOR_HISTORY" procedure=""> 
                <input bind="grdList" >
					<input bind="datWorkDateFr" /> 
					<input bind="datWorkDateTo" /> 
					<input bind="lstCompany_In" /> 
					<input bind="txtSearchInfo" /> 
					<input bind="lstVisit" /> 
					<input bind="lstApprove" /> 
                </input>
                <output  bind="grdList" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datVisitorDetail" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6" function="HR.SP_SEL_VISITOR_HISTORY_D" procedure=""> 
                <input bind="grdList_d" >
					<input bind="txtMaster_PK" /> 
                </input>
                <output  bind="grdList_d" />
            </dso> 
        </xml> 
</gw:data>

<table cellpadding="2" cellspacing="2" border=1 style="width:100%;height:100%;"> 
	<tr>
	    <td>
			<table cellpadding="1" cellspacing="1" border=0 style="width:100%;height:100%">
				<tr style="width:100%;height:1%" valign="top">
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
					<td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td><td width = "1%"></td>
				</tr>
				<tr style="width:100%;height:5%" valign="center">
					<td colspan="5" align = "right">Date</td>
					<td colspan="8" align = "right"><gw:datebox id="datWorkDateFr" lang="1" styles="width:100%" onchange="" ></gw:datebox></td>
					<td colspan="1" align = "right">~</td>
					<td colspan="8" align = "right"><gw:datebox id="datWorkDateTo" lang="1" styles="width:100%" onchange="" ></gw:datebox></td>
					<td colspan="18" align = "right"><a title="Click here to show list of visitor company" 
															onclick="OnShowVisCompanyPopup('MOD')" 
															href="#tips" >Vistor Company
														</a></td>
					<td colspan="15" align = "right">
						<gw:list  id="lstCompany_In"  maxlen = "100" value='ALL' onchange="OnSearchVisitorData()" >
							<data><%=ESysLib.SetListDataSQL("SELECT C.PK, C.COMPANY_NM FROM THR_VIS_COMPANY C WHERE C.DEL_IF = 0 ORDER BY C.COMPANY_NM")%>|ALL|Select All</data>
						 </gw:list>
					</td>
					<td colspan="10" align = "right">Information</td>
					<td colspan="17" align = "right"><gw:textbox id="txtSearchInfo" onenterkey = "OnSearchVisitorData()"/></td>
					<td colspan="2" align = "right"><gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearchVisitorData()"/></td>
					<td colspan="2" align = "right"><gw:imgBtn img="excel" id="ibtnSearch"   alt="report"  onclick="OnReport()"/></td>
					<td colspan="11" align = "right"><gw:label id="lblRecord"  text="0 rec(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
					<td colspan="1" align="right" valign="bottom" ><img status="expand" id="imgArrow" src="../../../system/images/iconmaximize.gif" alt="Show history"  style="cursor:hand" onclick="OnToggle()"  /> </td>
					
				</tr>
				<tr style="width:100%;height:5%" valign="center">
					<td colspan="14" align = "right">Visit Status</td>
					<td colspan="9" align = "right"><gw:list  id="lstVisit"  maxlen = "100" value='ALL' onchange="OnSearchVisitorData()" >
							<data>|W|WAITING|I|IN|O|OUT|ALL|Select All</data>
						 </gw:list>
				    </td>
				    <td colspan="5" align = "right">&nbsp;</td>
					<td colspan="12" align = "right">Approve Status</td>
					<td colspan="15" align = "right"><gw:list  id="lstApprove"  maxlen = "100" value='ALL' onchange="OnSearchVisitorData()" >
							<data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE A WHERE A.ID='HR0124' ORDER BY A.CODE")%>|ALL|Select All</data>
						 </gw:list>
				    </td>
				    <td colspan="46" align = "right">&nbsp;</td>
				</tr>
				<tr id="tr1" style="border:1;width:100%;height:89%">
				    <td colspan="100">
                            <gw:grid   
                                id="grdList"  
                                header="_VisPK|Visitor Name|Sex|Company|Vehicle No|Visitors|Card Type|Card Name|Card No|Visit Status|Approval Status|Gate In|Check In by|Gate Out|Check Out by|Contact To|Contact Point|Reason|In Description|Out Description|GA Response|_visit status|_approve"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                defaults="||||||||||||||||||||||"
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths="0|2000|2500|2500|2000|2000|2000|2000|2000|2000|2000|2500|2500|2500|2000|2000|2000|2000|2000|2000|3000|0|0"
                                styles="width:100%; height:100%" 
								acceptNullDate
                                sorting="T"    oncellclick="ShowDetail()" 
                            /> 
			        </td>
			      </tr>
			      <tr id="tr2" style="border:1;width:100%;height:20%">
				    <td colspan="100">
                            <gw:grid   
                                id="grdList_d"  
                                header="Property Description|Quantity|Serial No|Property Purpose|Description"
                                format="0|0|0|0|0"
                                aligns="0|0|0|0|0"
                                defaults="||||"
                                editcol="0|0|0|0|0"
                                widths="4000|2000|2500|2500|2100"
                                styles="width:100%; height:100%" 
								acceptNullDate
                                sorting="T"    oncelldblclick="" 
                            /> 
			        </td>
			      </tr>
			</table>
	    </td>
	</tr>
</table>
</body>
<gw:textbox id="txtMaster_PK" text="" styles="display:none"/> 
</html>
