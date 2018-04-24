<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("crm")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var gSave = false;
var year = "<% =Request.QueryString("YEAR") %>";
var lang="<%=Session("Lang")%>";
var v_data = new Array();
var close_flag;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);
   <%=ESysLib.SetGridColumnComboFormat("grdHoliday" , 3 , "SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE PARENT_CODE = 'HOLIDAY' AND USE_YN = 'Y' union all select '','' from dual") 
   %> 
   dtYear.SetDataText(year,lang);
   close_flag = 0;
   OnSearch();
}
//-------------------------------------
function OnSearch()
{
   
   datHoliday.Call("SELECT");
}
//-------------------------------------
function OnSave()
{
    close_flag=1;
	datHoliday.Call();
	
}
//-------------------------------------
function CheckDataIsValid()
{
   for(var i=1;i<grdHoliday.rows;i++)
   {
      
         if((grdHoliday.GetRowStatus(i)>=16)&&(grdHoliday.GetRowStatus(i)<=48))
         {
            
            if(grdHoliday.GetGridData(i,3)== "")
            {
               alert("Please select holiday type !");
               return false;
            }
            if(Trim(grdHoliday.GetGridData(i,4))== "")
            {
               alert("Please input holiday comment!");
               return false;
            }            
            
         }
     
   }
   return true;
}
//-------------------------------------
function OnClose()
{
   window.returnValue = close_flag;
   window.close();      
}
//-------------------------------------
function EXITOnClick()
{
	OnClose();
}
</script>
<body>
<!------------main control---------------------->

<gw:data id="datHoliday" > 
        <xml> 
            <dso  type="grid"  function="crm.sp_sel_holiday"  procedure="crm.sp_upd_holiday" parameter="0,1,3,4,5"> 
                <input bind="grdHoliday">
                    <input bind="lstHolidayType" /> 
                    <input bind="dtYear" />
                </input> 
                <output bind="grdHoliday"/>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table--------------------------------->
<table  style='margin-left:10px' width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
    <tr style="width:100%;height:100%">
        <td style="width:100%;height:100%">
            <table border=1 style="width:100%;height:100%" cellpadding="0"  cellspacing="0">
	            <tr style="height:5%">
	                <td width=15% align=right style="border:0"><font color=black><b>Holiday Type&nbsp;</b></font></td>
	                <td width=30% style="border:0">
	                     <gw:list id="lstHolidayType" value="ALL" styles="width:100%" onchange="OnSearch()" >
	                         <data><%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE PARENT_CODE = 'HOLIDAY' AND USE_YN = 'Y' ORDER BY ORD")%>|ALL|Select All</data>
	                     </gw:list>
	                </td>
	                <td width=10% align=right style="border:0"><font color=black><b>Month&nbsp;</b></font></td>
	                <td width=15% style="border:0"><gw:datebox id="dtYear" type="month" lang="<%=session("lang")%>" onchange="OnSearch()"/></td>
	                <td width=19% style="border:0"></td>
        	        
	                <td width=6% style="border:0"><gw:imgBtn id="ibtnSave" img="save" alt="Save" onclick="OnSave()" /></td>
	                <td width=5% style="border:0"><gw:imgBtn id="ibtnClose" img="cancel" alt="Close" onclick="OnClose()" /></td>
	            </tr>
	            <tr style="height:95%">
	                <td colspan=7>
	                   <gw:grid   
					        id="grdHoliday"  
					        header="_PK|Date|Day Type|Holiday Type|Comment|Remark|_DEL_IF|_CRT_BY|_CRT_DT|_MOD_BY|_MOD_DT"   
					        format="0|4|0|2|0|0|0|0|0|0|0"  
					        aligns="0|0|0|2|0|0|0|0|0|0|0"  
					        defaults="||||||||||"  
					        editcol="1|1|0|1|1|1|1|1|1|1|1"  
					        widths="0|1500|1500|2500|3000|2500|0|0|0|0|0"  
					        styles="width:100%; height:100%"   
					        sorting="T"   
					         /> 
	                </td>
	            </tr>
	        </table>
	    </td>
    </tr>
</body>
</html>
