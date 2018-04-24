<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit_date=true;
var binit_month=true;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
    grdEmpDate.GetGridControl().ScrollTrack=true;
   
  
  
   var p_user,p_date,p_date_text, p_org, p_from, p_to;
    p_org ="<%=Request("p_org")%>";
    p_from ="<%= Request("p_from")%>";
    p_ID = "<%=Request("p_pk")%>";
    p_to ="<%=Request("p_to")%>";
    var p_list =" <%=Request("p_list") %>";
    var p_temp = "<%=Request("p_temp")%>";
   
    dtMonthFrom.value=p_from;
    dtMonthTo.value=p_to;
    txtTemp.text=p_ID;
  datDailyEmpSearch_Dept.Call("SELECT");
    	
}
//---------------------------------------------------
//----------------------------------------------

function OnDataReceive(obj)
{ auto_resize_column(grdEmpDate,0,grdEmpDate.cols-1,10);    
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------------------------

//----------------------------------------------------
function OnSearch()
{  
datDailyEmpSearch_Dept.Call("SELECT");
}/**/ 

//-----------------------------------------------
//-----------------------------------------------

//-------------------------------------------------

//--------------------------------------------------

//----------------------------------------------
//----------------------------------------------
function ShowMonthlyDetail()
{  
} 
</script>
<body>
<!-------------------data control----------------------->

<!------------------------------------------------>
<!------------------------------------------------>

<!------------------------------------------------>
<gw:data id="datDailyEmpSearch_Dept" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   function="HR.sp_sel_emp_his_posco_detail"> 
                <input bind="grdEmpDate" >
                    <input bind="dtMonthFrom" />
                    <input bind="dtMonthTo" />
                    <input bind="txtTemp" />
                    
                    
                </input>
                <output  bind="grdEmpDate" />
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<!------------------------------------------------>
<!------------------------------------------------>
<!------------------------------------------------>
<!------------------------------------------------>
<!------------------------------------------------>
<!---------------------------table---------------------------->
    <table name="General" align = top cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr>
	    <td  align = top >
		    <table align=top  cellspacing=0 cellpadding=0 style="width:100%;height:10%;" border=0>
			   <tr style="width:100%;height:0%;">
			   <td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td>
			   <td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td>
			   <td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td>
			   <td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td>
			   <td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td><td style="width:2%"></td>
			   </tr>
			    <tr style="height:5%;">      
				    <td colspan="8" align=right><font color=Black>Period From</font></td>
            	    <td colspan="4" nowrap align="left"><gw:datebox id="dtMonthFrom" type="month" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>
			        <td  align="right">To</td>
			        <td colspan="4" nowrap align="left"><gw:datebox id="dtMonthTo" type="month" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>
			        <td colspan="6" align="right">Employee ID </td>
				    <td colspan="12">
				     <gw:textbox  id="txtTemp" csstype="mandatory" onenterkey   ="OnSearch()" styles='width:100%'csstype="mandatory"/>
				    </td>
                    <td></td>
				    <td><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch();"/></td> 
				    <td colspan="13"></td>
				    
				    
		        </tr>
		</table>
		    <table align=top  cellspacing=0 cellpadding=0 style="width:100%;height:90%;" border=1>
			    <tr  style="width:100%;height:100%;">
		            <td style="width:100%;height:100%;">
		            <gw:grid   
			            id="grdEmpDate"  
			            header="_pk|Employee ID|Employee Name|Join Date|Month|Organization|Band|Grade|Job Class|Job Title|_Confirm Date|Salary Basic|Salary Addition|Crane Salary "   
			            format="0|0|0|4|0|0|0|0|0|0|4|1|1|1"  
			            aligns="0|0|0|1|1|1|1|1|1|1|1|1|1|1"  
			            defaults="||||||||||||||"  
			            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			            widths="1000|1500|3500|2500|2500|2500|2500|2500|2500|2500|2500|2500|2500|2500"  
			            styles="width:100%; height:100%;"   
			            sorting="F"   
			            oncelldblclick     = ""/>
			         </td>
		        </tr>
		        
		    </table>
		    
		</td>
	</tr>
</table>
</body>

</html>
