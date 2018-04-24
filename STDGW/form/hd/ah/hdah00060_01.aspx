<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{       
    	
    txtEmp_PK.text="<%=Request.querystring("emp_pk")%>";
    txtFrom_DT.text="<%=Request.querystring("from_dt")%>";
    txtTo_DT.text="<%=Request.querystring("to_dt")%>";
    txtCol.text="<%=Request.querystring("col")%>";
    OnSearch();
}
function OnSearch()
{
    datDetail.Call();
}
function OnDataReceive(obj)
{
    if(obj.id=="datDetail")
    {
        if(txtCol.text==4)
            for(var i=1;i<grdDetail.rows;i++)
                grdDetail.SetCellBgColor(i,6,i,6,0x0099FF);
        else if(txtCol.text==5)                
            for(var i=1;i<grdDetail.rows;i++)
                grdDetail.SetCellBgColor(i,7,i,7,0x0099FF);
    }
}
//-----
function OnDisplay()
{
    if (grdDetail.row>0)
    {
        idShift.text=grdDetail.GetGridData(grdDetail.row,8);
    }
}
</script>
<body >
<!-------------------data control----------------------->
<!------------------------------------------>
<gw:data id="datDetail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1" function="HR_SEL_70010006_POP" procedure=""> 
                <input bind="grdDetail" >                    
                    <input bind="txtEmp_PK" />
                    <input bind="txtFrom_DT" />
                    <input bind="txtTo_DT" />
                    <input bind="txtCol" />
                </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                     <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=12  style="border:0" align="center" valign="middle">
                          <font size=5>Late in and Early out in Details</font>
                        </td>					                            
				       
                    </tr>     
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan=12  style="border:0" align="right" valign="middle">
                          <gw:label id="idShift" text="" styles="width:100%" ></gw:label>
                        </td>					                            
				       
                    </tr>     
                                                       
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=15 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdDetail"  
                                header="Org Name|EmpID|Name|Join Date|Work Shift|Work Date|In Time|Out Time|_Remark" 
                                format="0|0|0|4|0|4|0|0|0"  
                                aligns="0|0|0|1|1|1|1|1|0"  
                                defaults="|||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0"  
                                widths="2000|1000|3000|1200|1000|1200|1000|1000|0"  
                                styles="width:100%; height:100%" 
								
                                sorting="T"    oncellclick="OnDisplay()"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtFrom_DT" styles="display:none"/>
<gw:textbox id="txtTo_DT" styles="display:none"/>
<gw:textbox id="txtCol" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</html>
