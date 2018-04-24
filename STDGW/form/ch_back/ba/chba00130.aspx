<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
var icTime=2;
var icID=4;
var icByHand=6;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
   
    idUserID.text= "<%=session("USER_ID")%>";
    grdTEnter.GetGridControl().ScrollTrack=true;
}
function OnDataReceive(obj)
{
       if(obj.id=="datTimeControlEnter")
       {
          idRecord.text=grdTEnter.rows-1+" Records."; 
       }
}   
//---------------------------------
function OnSearch()
{
    datTimeControlEnter.Call("SELECT");
}
//---------------------------------
function OnAdd()
{
    grdTEnter.AddRow();
}
//----------------------------------
function On_AfterEdit()
{
    icol=event.col;
     var sTime=grdTEnter.GetGridData(event.row,icTime)
     var sByHand=grdTEnter.GetGridData(event.row,icByHand)
    if (sByHand=='Y' || sByHand=='' )
    {
        if (icol==icTime)
	    {
		    
		    if((sTime.length!=6)&&(sTime.length!=0))
		    {
			    alert("Input time is not correct type.(type: hhmmss)\nKiểu giờ nhập không đúng")
			    grdTEnter.SetGridText(event.row,icol,'')
			    return;
		    }
		    if((Number(sTime.substr(0,2))>=24)||(Number(sTime.substr(0,2))<0))
		    {
			    alert("Input time(Hour) is not correct type.(00<= hh <= 23)\nKiểu giờ phải >=00 và <=23")
			    grdTEnter.SetGridText(event.row,icol,'')
			    return;
		    }
		    if((Number(sTime.substr(2,2))>=60)||(Number(sTime.substr(2,2))<0))
		    {
			    alert("Input time(Minute) is not correct type.(00<= hh < 59)\nKiểu phút phải >=00 và <=59")
			    grdTEnter.SetGridText(event.row,icol,'')
			    return;
		    }
		    if((Number(sTime.substr(4,2))>=60)||(Number(sTime.substr(4,2))<0))
		    {
			    alert("Input time(Second) is not correct type.(00<= ss < 59)\nKiểu giây phải >=00 và <=59")
			    grdTEnter.SetGridText(event.row,icol,'')
			    return;
		    }
		       
	    }
	    else if (icol==icID)
	    {
	        var sID=grdTEnter.GetGridData(event.row,icol)
	        if(isNaN(sID))
	        {
	            alert("Please input Number \n Vui lòng nhập kiểu số")
			    grdTEnter.SetGridText(event.row,icol,'')
			    return;
	        }    
	    }
	}
	
}
//---------------------------------
function OnSave()
{
    if (confirm("Do you want to save data? \n Bạn có muốn lưu không?") )
        if (CheckValidData())
            datTimeControlEnter.Call();
}
//----------------------------------
function CheckValidData()
{
    for (var i=1;i<grdTEnter.rows;i++)   
    {
        if (grdTEnter.GetRowStatus()!=0 && grdTEnter.GetRowStatus()!=64)
        {
            if (grdTEnter.GetGridData(i,icTime)=="")
            {
                alert("Please input E_Time \n Vui lòng nhập giờ")
                return 0;
            }    
            if (grdTEnter.GetGridData(i,icID)=="")
            {
                alert("Please input E_ID \n Vui lòng nhập ID")
                return 0;
            }
        }
    }
    return 1;
}
//---------------------------------
function OnDelete()
{
    if (confirm("Do you want to delete data? \n Bạn có muốn xóa không?"))
    {
        grdTEnter.DeleteRow();
        datTimeControlEnter.Call();
    }
}
//---------------------------------
function OnReport()
{
    var url =System.RootURL + '/reports/ch/ba/rpt_time_control_tenter.aspx?p_from=' + FromDT.value + '&p_to=' + ToDT.value + '&p_search=' + idSearch.value  + '&P_input=' +  idtxtTmp.text  + '&p_input_by_hand=' + lstByHand.value  ;
    window.open(url);
     
     
}

//-------------------------------------------------------------------------------------------
</script>
<body>
<!------------------------------------------------>
<gw:data id="datFind_User" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_sel_user_hr_tmp" > 
                <input>
                    <input bind="idUserID" /> 
                </input> 
                <output>
                    <output bind="txtReturn" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datTimeControlEnter" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr.SP_sel_time_control_enter" procedure="hr.SP_upd_time_control_enter" parameter="0,1,2,3,4,5,6"> 
                <input bind="grdTEnter"> 
                    <input bind="FromDT" /> 
                    <input bind="ToDT" /> 
                    <input bind="lstByHand" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                </input> 
                <output bind="grdTEnter"/>
            </dso> 
        </xml> 
</gw:data>

   <!--------------------main table----------------------------------->
    <table name="Rolling Gate" id="Rolling" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:10%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td  style="width:10%" align="right">Work DT</td>
                    <td  align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=center style="width:3%;border:0"><b>~</b></td>
		            <td  align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td  align=right style="width:10%">Input by Hand</td>
		            <td  align=right style="width:7%"><gw:list  id="lstByHand" value="Y" styles="width:96%" onChange="">
                            <data>|Y|Yes|N|No|ALL|Select All</data></gw:list></td>
		            <td align=right style="width:7%">Search by</td>
		            <td  align=right style="width:8%"><gw:list  id="idSearch" value="1" styles="width:96%" onChange="">
                            <data>|1|Card ID|2|Name</data></gw:list></td>
                    <td  align=right style="width:10%"><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:96%" onenterkey="OnSearch()" /></td>
		            <td  align=right style="width:10%"style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
                    <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
                    <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnAdd" alt="Add" img="new" text="Add" onclick="OnAdd()" /></td>
                    <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnAdd" alt="Save" img="save" text="Add" onclick="OnSave()" /></td>
                    <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnAdd" alt="Delete" img="delete" text="Add" onclick="OnDelete()" /></td>
                    <td align=right style="width:3%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport()" /></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:90%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid id='grdTEnter'
                            header='_O_E_DATE|E_DATE|E_TIME(HHMISS)|_O_E_ID|E_ID|E_NAME|INPUT_BY_HAND'
                            format='0|4|0|0|0|0|0'
                            aligns='0|1|1|1|1|0|1'
                            defaults='||||||'
                            editcol='1|1|1|1|1|1|0'
                            widths='780|2500|2010|2000|2025|4030|1000'
                            sorting='T'
                            styles='width:100%; height:100%' 
                            onafteredit="On_AfterEdit()"
					        />
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    <gw:textbox id="idUserID" styles="display:none"/>
    <gw:textbox id="txtReturn" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>  
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
</body>

   
</html>
