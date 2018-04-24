<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
//----------------
var c_pk=0;
var c_id=1;
var c_title=2;
var c_role_kind=3;
var c_content=4;
var c_at_time_date=5;
var c_at_time_month=6;
var c_at_time_year=7;
var c_at_time_sysdate=8;
var c_sql=9;
var c_cycle_time=10;
var c_cycle_type=11;
var c_times=12;
var c_columns=13;
var c_url=14;
var c_search_key=15;
var c_announce_type=16;
//---------------
var flag_Add=false;
var cur_row=0;
function BodyInit()
{   
    System.Translate(document); 
    var str_code = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0141' order by code_nm")%>";
    grdAnnounce.SetComboFormat(c_role_kind,str_code);
    str_code = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0142' order by code_nm")%>";
    grdAnnounce.SetComboFormat(c_announce_type,str_code);
    datAnnouncement_Infor.Call("SELECT");
   
}
function OnAddNew()
{
    grdAnnounce.AddRow();
    OnReset();                
}
function OnReset()
{
    flag_Add=true;
    txtPK.text="";
    txtaContent.SetData("");
    txtDate.text="";
    txtMonth.text="";
    txtYear.text="";
    chkbSysdate.SetDataText("F");
    txtaSQL.SetData("");
    txtCycle_Time.text="";
    txtTimes.text="";
    txtColumns.text="";
    txtCycle_Time.GetControl().disabled=false;
    txtTimes.GetControl().disabled=false;
    
}
//--------------------------------
function OnUpdate()
{
    //get data into grid
    var row_update=0;
    if (txtPK.text=="")
    {
        if (flag_Add==true) //add new
            row_update=grdAnnounce.rows-1;
    }   
    else
        row_update=cur_row; 
    if (row_update>0 && CheckData())
    {
        if (confirm("Do you want to save infor?"))
        {
            SetGridData(row_update);
            datAnnouncement_Infor.Call();
        }
    }
}
//-----------------------------
//header='_PK|ID|TITLE|ROLE KIND|_CONTENT|_AT_TIME_DATE|_AT_TIMES_MONTH|_AT_TIME_YEAR|_AT_TIME_SYSDATE|_SQL|_CYCLE_TIMES|_CYCLE_TYPE|
//_TIMES|_COLUMNS|_URL|_SEARCH KEY|ANNOUNCE TYPE'

function SetGridData(irow)
{
    grdAnnounce.SetGridText(irow,c_content,txtaContent.GetData());
    grdAnnounce.SetGridText(irow,c_at_time_date,txtDate.text);
    grdAnnounce.SetGridText(irow,c_at_time_month,txtMonth.text);
    grdAnnounce.SetGridText(irow,c_at_time_year,txtYear.text);
    grdAnnounce.SetGridText(irow,c_at_time_sysdate,chkbSysdate.GetData());
    grdAnnounce.SetGridText(irow,c_sql,txtaSQL.GetData());
    grdAnnounce.SetGridText(irow,c_columns,txtColumns.text);
    grdAnnounce.SetGridText(irow,c_cycle_time,txtCycle_Time.text);
    grdAnnounce.SetGridText(irow,c_cycle_type,lstCycle_Type.value);
    grdAnnounce.SetGridText(irow,c_times,txtTimes.text);
    grdAnnounce.SetGridText(irow,c_url,txtURL.text);
    grdAnnounce.SetGridText(irow,c_search_key,txtSearch_Key.text);
    
}
//-----------------------------
function GetGridData(irow)
{
    
    txtaContent.SetDataText(grdAnnounce.GetGridData(irow,c_content));
    txtDate.text            =grdAnnounce.GetGridData(irow,c_at_time_date);
    txtMonth.text           =grdAnnounce.GetGridData(irow,c_at_time_month);
    txtYear.text            =grdAnnounce.GetGridData(irow,c_at_time_year);
    chkbSysdate.SetDataText(grdAnnounce.GetGridData(irow,c_at_time_sysdate));
    txtaSQL.SetDataText(grdAnnounce.GetGridData(irow,c_sql));
    txtColumns.text         =grdAnnounce.GetGridData(irow,c_columns);
    txtCycle_Time.text      =grdAnnounce.GetGridData(irow,c_cycle_time);
    lstCycle_Type.value     =grdAnnounce.GetGridData(irow,c_cycle_type);
    txtTimes.text           =grdAnnounce.GetGridData(irow,c_times);
    txtURL.text             =grdAnnounce.GetGridData(irow,c_url);
    txtSearch_Key.text       =grdAnnounce.GetGridData(irow,c_search_key);
    OnChangeCycle();
}
//----------------------------
function CheckData()
{
    if (txtaContent.GetData()=="")
    {    alert("Please input content!");
        txtaContent.GetControl().focus();
        return 0;
    }
    if ((txtDate.text=="" && txtMonth.text=="" && txtYear.text=="") && chkbSysdate.GetData()=='F')
    {
        alert("Please select At time!");
        txtDate.GetControl().focus();
        return 0;
    }
    
    
    if ((txtDate.text!="" || txtMonth.text!="" || txtYear.text!="") && chkbSysdate.GetData()=='T')
    {
        alert("Please just input time (day, month, year) or check Every day!");
        txtDate.GetControl().focus();
        return 0;
    }
    if ((txtDate.text<0 || txtDate.text>31) && txtDate.text!="")
    {
        alert("Please day exactly (1->31)!");
        txtDate.GetControl().focus();
        return 0;
    }
    if ((txtMonth.text<0 || txtMonth.text>12) && txtMonth.text!="")
    {
        alert("Please month exactly (1->12)!");
        txtMonth.GetControl().focus();
        return 0;
    }
    if (txtMonth.text.length!=4 && txtYear.text!="")
    {
        alert("Please year exactly (4 number)!");
        txtYear.GetControl().focus();
        return 0;
    }
    if ((txtaSQL.GetData()!="" && txtColumns.text=="") || (txtaSQL.GetData()=="" && txtColumns.text!=""))
    {
        alert("Please input SQL and Columns OR clear all !");
        txtaSQL.GetControl().focus();
        return 0;
    }
    if (txtCycle_Time.text=="" && lstCycle_Type.value !="not" )
    {
        alert("Please input Cycle Time or choose Not Repeat!");
        txtCycle_Time.GetControl().focus();
        return 0;
    }
    return 1;
}
//-------------------------
function OnSelectRow()
{
    cur_row=grdAnnounce.row;
    txtPK.text=grdAnnounce.GetGridData(cur_row,c_pk);
    GetGridData(cur_row);
}
//-----------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datAnnouncement_Infor")
   {
        flag_Add=false;
        lblRecord.text=grdAnnounce.rows-1 + " record(s).";
   }
}
//---------------------
function OnChangeCycle()
{
    if (lstCycle_Type.value =="not")
    {
        txtCycle_Time.text="";
        txtTimes.text="";
        txtCycle_Time.GetControl().disabled=true;
        txtTimes.GetControl().disabled=true;
    }
    else
    {
        txtCycle_Time.GetControl().disabled=false;
        txtTimes.GetControl().disabled=false;
        
    }
}
//--------------------------
function OnDelete()
{
    if (confirm("Do you want to delete?"))
        grdAnnounce.DeleteRow();
}
//--------------------------
function OnUnDelete()
{
    if (confirm("Do you want to undelete?"))
        grdAnnounce.UnDeleteRow();
}
//---------------------
function OnChange_Every()
{
    if (chkbSysdate.GetData()=="T")
    {
        lstCycle_Type.value ="not";
        txtDate.text        ="";
        txtMonth.text       ="";
        txtYear.text        ="";
        OnChangeCycle();
    }
}
//-----------------------------------------------
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
//------------------------------
function OnNote()
{
    var fpath = System.RootURL + "/form/ag/bh/agbh00170_note.aspx" ; 
    System.OpenModal(  fpath , 700 , 450 , 'resizable:yes;status:yes');
        
}
</script>

<body>
<!------------main control---------------------->
<!------------------------------------------------------>
<gw:data id="datAnnouncement_Infor" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="HR_SEL_80020015"  procedure="HR_UPD_80020015" > 
                <input bind="grdAnnounce" >
                </input>
                <output  bind="grdAnnounce" />
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table--------------------------------->
<form name="General Reports" id="form1">
<table style="width:100%;height:93%" cellpadding="0" cellspacing="0" align="top" border="0" >
	<tr>
	    <td style="width:50%;height:100%" cellpadding="0" cellspacing="0">
	        <fieldset style="height:93%;" cellpadding="0" cellspacing="0" > 
                <legend style="border:1"><font color="#0066cc" size="2">Master</font></legend>
	            <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	                <tr style="height:5%;border:0">	
		                <td align=right style="width:50%;border:0"><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
		                <td align=right style="width:10%;border:0"><gw:imgBtn id="ibtnNew" alt="New" img="new" text="New" onclick="OnAddNew()" /></td>
		                <td align=right style="width:10%;border:0"><gw:imgBtn id="ibtnSave" alt="Save" img="save" text="Save" onclick="OnUpdate()" /></td>
		                <td align=right style="width:10%;border:0"><gw:imgBtn id="ibtnDel" alt="Delete" img="delete" text="Delete" onclick="OnDelete()" /></td>
		                <td align=right style="width:10%;border:0"><gw:imgBtn id="ibtnUDel" alt="UnDelete" img="udelete" text="UnDelete" onclick="OnUnDelete()" /></td>
		                <td align=right style="width:10%;border:0"><gw:imgBtn id="ibtnNote" alt="Note" img="confirm" text="Note" onclick="OnNote()" /></td>
                    </tr>
	                <tr style="height:95%;border:0">	
	                   <td align=center id="tdMaster" style="width:100%" colspan=6>
	                       <gw:grid id='grdAnnounce'
                            header='_PK|ID|TITLE|ROLE KIND|_CONTENT|_AT_TIME_DATE|_AT_TIMES_MONTH|_AT_TIME_YEAR|_AT_TIME_SYSDATE|_SQL|_CYCLE_TIMES|_CYCLE_TYPE|_TIMES|_COLUMNS|_URL|_SEARCH KEY|ANNOUNCE TYPE'
                            format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            check='||||||||||||||||'
                            editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                            widths='1000|500|6000|1200|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1200|1000'
                            sorting='T'
                            styles='width:100%; height:100%'
                            resize='T'
                            oncellclick="OnSelectRow()"
                            />
	                    </td>
                    </tr>	
	            </table>
	        </fieldset>
	    </td>
	    <td style="width:50%;height:100%;border:0" cellpadding="0" cellspacing="0">
	      <fieldset style="height:93%;" cellpadding="0" cellspacing="0"> 
                <legend style="border:0"><font color="#0066cc" size="2"  >Details</font></legend>
	            <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	                <tr style="height:5%;border:0">	
	                    <td align=left id="td5" style="width:49%;border:0">Content</td>
	                    <td align=left id="td7" style="width:2%;border:0"></td>
	                    <td align=left id="td6" style="width:49%;border:0">At time</td>
                    </tr>	
	                <tr style="height:30%;border:0">	
	                     <td align=center style="border:0"id="td1" >
	                        <gw:textarea id="txtaContent" styles="width:100%;height:95%;font-size:15"/>
	                    </td>
	                    <td align=left ></td>
	                    <td align=center id="td3" style="border:0">
	                         <fieldset style="height:30%;" cellpadding="0" cellspacing="0"> 
	                        <table  style="width:100%;height:30%;border:0">
	                            <tr style="width:100%;height:25%">
	                                
	                                <td align=left id="td22" style="width:10%"></td>
	                                <td align=left id="td13" style="width:20%">Date</td>
	                                <td align=left id="td14" style="width:70%"> <gw:textbox id="txtDate"  text="" 	styles='width:100%;' onkeypress="return Numbers(event)" /></td>
	                            </tr>
	                            <tr style="width:100%;height:25%;border:0" >
	                                <td align=left id="td23" style="width:10%"></td>
	                                <td align=left id="td15" style="width:20%">Month</td>
	                                <td align=left id="td18" style="width:70%"> <gw:textbox id="txtMonth"  text="" 	styles='width:100%;' onkeypress="return Numbers(event)"  /></td>
	                             </tr>
	                            <tr style="width:100%;height:25%;border:0" valign="top">
	                                <td align=left id="td24" style="width:10%"></td>
	                                <td align=left id="td17" style="width:20%">Year</td>
	                                <td align=left id="td19" style="width:70%"><gw:textbox id="txtYear"  text="" 	styles='width:100%;' onkeypress="return Numbers(event)" /></td>
	                            </tr>
	                            <tr style="width:100%;height:25%;border:0" valign="top">
	                                <td align=left id="td25" style="width:10%"></td>
	                                <td align=left id="td20" style="width:20%" valign=middle>Every Day</td>
	                                <td align=left id="td21" style="width:70%" valign=top><gw:checkbox id="chkbSysdate"   onchange="OnChange_Every()"	styles='width:10%;'  /></td>
	                            </tr>
	                        </table> 
	                        </fieldset>
	                    </td>
                    </tr>	
                    <tr style="height:5%;border:0">	
	                    <td align=left id="td4" style="width:49%;border:0">SQL</td>
	                    <td align=left id="td8" style="width:2%;border:0"></td>
	                    <td align=left id="td9" style="width:49%;border:0">Columns</td>
                    </tr>
                    <tr style="height:60%;border:0">	
	                     <td align=center id="td2" style="border:0">
	                        <gw:textarea id="txtaSQL" styles="width:100%;height:280;font-size:15"/>
	                    </td>
	                    <td align=left ></td>
	                     <td align=center style="width:100%;border:0">
						 
	                         <fieldset style="height:8%" cellpadding="0" cellspacing="0"> 
	                                <table  style="width:100%;border:0;height:100%">
	                                    <tr style="width:100%;border:0" valign="top">
	                                         <td align=left  id="td16" style="width:100%;border:0"> <gw:textbox id="txtColumns"  text="" styles='width:100%;'  /></td>
	                                    </tr>
	                                </table>  
	                            </fieldset>
	                            <table  style="width:100%;height:8%;border:0">
	                                <tr style="width:100%;border:0" valign="bottom">
	                                    <td align=left  height=10%  id="td27" style="width:100%;border:0">Cycle</td>
	                                 </tr>
	                            </table>
	                            <fieldset style="height:8%;" cellpadding="0" cellspacing="0"> 
	                                <table  style="width:100%;border:0;">
	                                    <tr style="width:100%">
	                                        <td align=left  height=10%  id="td11" style="width:50%"> <gw:textbox id="txtCycle_Time"  text="" 	styles='width:100%;'  /></td>
	                                        <td align=left id="td12" style="width:50%">  <gw:list  id="lstCycle_Type" value="" onchange="OnChangeCycle()" maxlen = "100" styles='width:100%'  >
	                                            <data>LIST|dd|Day|mm|Month|yyyy|Year|not|Not Repeat</data>
                                            </gw:list> </td>
	                                    </tr>
	                                </table>  
	                            </fieldset>
	                             <table  style="width:100%;height:8%;border:0">
	                                <tr style="width:100%;border:0" valign="bottom">
	                                    <td align=left colspan=2 id="td26" style="width:50%;border:0">Times</td>
	                                 </tr>
	                            </table>
	                            <fieldset style="height:8%" cellpadding="0" cellspacing="0"> 
	                                <table  style="width:100%;border:0;">
	                                    <tr style="width:100%;border:0" valign="top">
	                                         <td align=left  height=10%  colspan=2 id="td10" style="width:50%;border:0"> <gw:textbox id="txtTimes"  text="" 	styles='width:100%;'  /></td>
	                                    </tr>
	                                </table>  
	                            </fieldset>
	                            <table  style="width:100%;height:8%;border:0">
	                                <tr style="width:100%;border:0" valign="bottom">
	                                    <td align=left colspan=2 height=10%  id="td28" style="width:50%;border:0">URL</td>
	                                 </tr>
	                            </table>
	                            <fieldset style="height:8%" cellpadding="0" cellspacing="0"> 
	                                <table  style="width:100%;border:0;">
	                                    <tr style="width:100%;border:0" valign="top">
	                                         <td align=left height=10%  colspan=2 id="td29" style="width:50%;border:0"> <gw:textbox id="txtURL"  text="" 	styles='width:100%;'  /></td>
	                                    </tr>
	                                </table>  
	                            </fieldset>
	                            <table  style="width:100%;height:10%;border:0">
	                                <tr style="width:100%;border:0" valign="bottom">
	                                    <td height=10%  align=left colspan=2 id="td30" style="width:50%;border:0">Search Options</td>
	                                 </tr>
	                            </table>
	                            <fieldset style="height:8%" cellpadding="0" cellspacing="0"> 
	                                <table  style="width:100%;border:0;">
	                                    <tr style="width:100%;border:0" valign="top">
	                                         <td height=10% align=left  colspan=2 id="td31" style="width:50%;border:0"> <gw:textbox id="txtSearch_Key"  text="" 	styles='width:100%;'  /></td>
	                                    </tr>
	                                </table>  
	                            </fieldset>
	                      
	                    </td>
	                    
                    </tr>	
                 
	            </table>
	         </fieldset>
	    </td>
	</tr>
</table>
</form>
<gw:textbox id="txtPK" style="display:none" />
</body>
</html>

