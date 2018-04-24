<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("comm")%>
<head id="Head1" runat="server">
    <title>Search Requester</title>
</head>
<script>
function BodyInit()
 {    
    System.Translate(document);  // Translate to language session
 }
 
function OnSearch()
{
    datEmployeePopup.Call("SELECT");
}
function OnSelect()
{
    OnExit();
}
function OnExit()
{
    var obj= Array();
    var irow;
    irow=grdEmployee.row;
    if (irow>0) 
    {
        obj[0]=grdEmployee.GetGridData(irow,0); //pk
        obj[1]=grdEmployee.GetGridData(irow,3); //emp id
        obj[2]=grdEmployee.GetGridData(irow,5); //full name
        obj[3]=grdEmployee.GetGridData(irow,8); //join date
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}
function EXITOnClick()
{
	OnExit();
}
</script>
<body  bgcolor='#F5F8FF'>
<!-- MainTable -->
<gw:data id="datEmployeePopup"> 
    <xml> 
        <dso  type="grid" function="imex.sp_sel_epgd00010_1"> 
            <input> 
                <input bind="lstDept" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<table style='margin-left:10px' align = top class="itable" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr> 
	    <td  align = top >
		    <table align = top  width="100%" style="height:5%">
		        <tr>
			        <td align="Left">
				        <table  width="100%"  border="0" CELLSPACING="0" CELLPADDING="0" >
					        <tr>   
						        <td width="10%" align="right"><font color="black"><b >Department &nbsp;</b>
						        </td>
						        <td width="25%"><gw:list id="lstDept" styles="color:black;width:100%" value="ALL" onchange=""> 
	                                           <data><%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org where del_if = 0 order by org_nm")%>|ALL|Select All</data>
	                                           </gw:list > 
						        </td>
						        <td width="10%" align="right"><font color="black"><b>Search by &nbsp;</b>
						        </td>
						        <td width="8%">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td width="25%"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td width="4%" ></td>
						        <td width="3%" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>						        
						        <td width="2%" >
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	<tr align = top> 
	    <td align = top  width="100%" style="height:95%" >
  		    <gw:grid   
			    id="grdEmployee"  
			    header="_PK|Department|Group|Emp ID|Card ID|Full Name|OLD CODE|Personal ID|Join Date"   
			    format="0|2|0|0|0|0|0|0|0"  
			    aligns="0|2|2|0|0|0|0|1|1"  
			    defaults="|||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0"  
			    widths="0|2000|1500|1000|1000|2500|1000|1250|800"  
			    styles="width:100%; height:500"   
			    sorting="T"   
			    param="0,1,2,3,4,5,6,7,8"  oncelldblclick ="OnSelect()" /> 
    	
  	    </td>
    </tr>
</table>

</body>
</html>

				
