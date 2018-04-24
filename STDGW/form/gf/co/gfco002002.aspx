<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>

<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("acnt");%>

<script>

function BodyInit()
{
   txtCode.text     = "<%=Request["code"]%>" ; 
   txtName.text     = "<%=Request["nm"]%>"; 
   txtName2.text    = "<%=Request["nm2"]%>" ;
   txtVal1.text     = "<%=Request["leaf_yn"]%>" ;
   txtVal2.text     = "<%=Request["use_yn"]%>" ;
   txtVal3.text     = "<%=Request["company"]%>" ;
   OnSearch();
}
function OnSearch()
{
    dsoAccountT.Call("SELECT");
}

function OnCancel()
{
	var code_data=new Array();
	tmp= new Array();
	tmp[0]       = 0
	code_data[0] = tmp;
	
	window.returnValue = code_data; 
	this.close();
	
}

function Selects()
{
	var aValue = new Array();
	for(i=1;i<idGrid.rows;i++)
    {
		if(idGrid.GetGridData(i,5)== "-1")
		{
			tmp= new Array();
			for(j=0;j<idGrid.cols;j++)
            {
				tmp[tmp.length] = idGrid.GetGridData(i,j);
			}
			aValue[aValue.length]=tmp; 
		}
    }
	window.returnValue = aValue; 
	window.close(); 
}

function Select()
{
	var aValue = new Array();
	var ctrl = idGrid.GetGridControl();
	tmp= new Array();
	for(j=0;j<idGrid.cols;j++)
	{
		tmp[tmp.length] = idGrid.GetGridData(ctrl.row,j);
	}
	aValue[aValue.length]=tmp; 

	window.returnValue = aValue; 
	window.close(); 
}

function OnCheck()
{
    for(i=1;i<idGrid.rows;i++)
    {
        if(idGrid.GetGridData(i,5)== "-1")
        {
            idGrid.SetGridText(i,5,0);
            btnCheck.text = "Chk All";
        }
        else
        {
            idGrid.SetGridText(i,5,-1);
            btnCheck.text = "Un Chk";
        }
    }
}

function onRowDBClick()
{
    grid    = idGrid.GetGridControl();
    var x   = (parseInt(grid.textmatrix(grid.row,5))+1)%2 ;
    grid.textmatrix(grid.row,5) =   x;
}

</script>

<body>

    <gw:data id="dsoAccountT"  onreceive="" > 
        <xml> 
           <dso type="grid" function="ACNT.SP_SEL_ACCT_POPUP" > 
                  <input bind="idGrid" > 
                    <input bind="txtCode"/> 
                    <input bind="txtName"/> 
                    <input bind="txtName2"/>
                    <input bind="txtVal1"/>
                    <input bind="txtVal2"/>
                    <input bind="txtVal3"/>
                   </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

<form id="form1" runat="server">
    <table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td width="100%" height="100%">
    	    <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=1>
                <tr height="15%">
	                <td > 
			            <table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
						<tr>
						    <td width="25%" align="right"><b>Account Code</b></td>
							<td width="70%"><gw:textbox id="txtCode" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
							<td width="5%"></td>
							
		                </tr>
		                <tr>
		                    <td width="25%" align="right"><b>Account Name</b></td>
							<td width="70%"><gw:textbox id="txtName" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
							<td width="5%"></td>
							
						</tr>  
		                <tr>
							<td width="25%" align="right"><b>Upper Account Name&nbsp;&nbsp;</b></td>
							<td width="70%"><gw:textbox id="txtName2" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
							<td width="5%" align="left"><gw:icon id="btnCheck" img="in" text="Chk All" onclick="OnCheck()"/></td>
						</tr>		        
				        </table>
		            </td>
	    	    </tr>
	    	    <tr height="80%"> 
	    		    <td>
	    			    <table CELLSPACING="0" CELLPADDING="0" width="100%" height="100%">
	    				<tr>
					    	<td height="80%">   
							<gw:grid   
							    id="idGrid"  
							    header="Account Code|Account Name|Upper Account Name|_PK|_value|Chk|Cust YN|Cust Remyn|PL Y/N|BGCon Y/N|DRCR Type|Bank Y/N|Emp Y/N|Mandatory 1|Y/N|Mandatory 2|Y/N|Mandatory 3|Y/N|Mandatory 4|Y/N|Mandatory 5|Y/N|Mandatory 6|Y/N|Mandatory 7|Y/N|Mandatory 8|Y/N|Mandatory 9|Y/N|Mandatory 10|Y/N|"
							    format="0|0|0|0|0|3|0|0|0"
							    aligns="1|0|0|0|0|0|0|0|0"  
							    defaults="||||||||"  
							    editcol="0|0|0|0|0|0|0|0|0"  
							    widths="1300|2500|2500|500|0|0|0|0|0"  
							    styles="width:100%; height:100%"   
							    sorting="T"   
							    param="0,1,2,3,4,5,6,7,8" 
							    oncelldblclick="onRowDBClick()"
							     />
				            </td>
		            	</tr>
		                </table>
            	    <td>
	    	    </tr>

		        <tr height="5">
				    <td>
					    <table border=0 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
						    <tr align="center"> 
							<td>
								<table>
									<tr>
										<td><gw:icon id="btnSelect" img="in" text="OK" styles="width:100"  onclick="Selects()" /></td>
										<td><gw:icon id="btnCancel" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" /></td> 
									</tr>
								</table>	
							<td>	
						    </tr>
					    </table>
				    </td>
			    </tr>
		    </table>  
        </td>
	</tr>
    </table>
</form>

<gw:textbox id="txtVal1"   text="Y" style="display: none" />
<gw:textbox id="txtVal2"   text="" style="display: none" />
<gw:textbox id="txtVal3"   text="" style="display: none" />

</body>
</html>
