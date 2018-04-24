<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>genuwin</title>
</head>
<%ESysLib.SetUser("acnt")%>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{
    System.Translate(document);
    var comp_pk  = "<%=Request.querystring("comp_pk")%>";
    txtCOMPANY.text = comp_pk;
   
}
function OnSearch()
{
    dsoAccountT.Call("SELECT");
}

function OnCancel()
{
	var code_data=new Array();
	tmp= new Array();
	tmp[0]       = 0;
	tmp[1]       = 0;
	code_data[0] = tmp;
	
	window.returnValue = code_data; 
	this.close();
	
}

function Selects()
{
	var aValue = new Array();
	var n = 0;
	for(i=1;i<idGrid.rows;i++)
    {
		if(idGrid.GetGridData(i,0)== "-1")
		{
			var tmp = new Array(4);
			for(j=0;j<6;j++)
            {
				tmp[j] = idGrid.GetGridData(i,j+1);
				
			}
			aValue[n]=tmp;
            n++;
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
	for(j=0;j<6;j++)
	{
		tmp[j] = idGrid.GetGridData(ctrl.row,j+1);
	}
	aValue[0]=tmp; 

	window.returnValue = aValue;
	window.close(); 
	
}

function OnCheck()
{
    for(i=1;i<idGrid.rows;i++)
    {
        if(idGrid.GetGridData(i,0)== "-1")
        {
            idGrid.SetGridText(i,0,0);
            btnCheck.text = "Chk All";
        }
        else
        {
            idGrid.SetGridText(i,0,-1);
            btnCheck.text = "Un Chk";
        }
    }
}

</script>

<body>

    <gw:data id="dsoAccountT"  onreceive="" > 
        <xml> 
           <dso type="grid" function="ACNT.SP_SELECT_FROM_ITEM"> 
                  <input bind="idGrid" > 
                    <input bind="txtCOMPANY" />
                    <input bind="txtCode"/> 
                    <input bind="txtName"/> 
                    <input bind="txtGrp"/>
                  
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

<form id="form1" runat="server">
    <table  border="0" width="100%" cellpadding="0" cellspacing="0" >
        <tr>
            <td width="25%" align="right">Group Code&nbsp;</td>
            <td width="70%"><gw:textbox id="txtGrp" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
        </tr>
        <tr>
            <td width="25%" align="right">Item Code&nbsp;</td>
            <td width="70%"><gw:textbox id="txtCode" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
        </tr>
        <tr>
            <td width="25%" align="right">Item Name&nbsp;</td>
            <td width="70%"><gw:textbox id="txtName" styles="width:98%;height:20" onenterkey="OnSearch()"/></td>
            <td width="5%" align="left"><gw:icon id="btnCheck" img="in" text="Chk All" onclick="OnCheck()"/></td>
        </tr>
        <tr>
            <td colspan="3">
                <table border=1 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
				    <tr align="center"> 
				        <td>
                            <gw:grid   
			                    id="idGrid"  
			                    header  ="CHK|_Pk|Item Code|Item Name|Unit|_grp|_tin_warehouse_pk"
                                format  ="3|0|0|0|0|0|0"
                                aligns  ="0|0|0|0|0|0|0"
                                defaults="||||||"
                                editcol ="0|0|0|0|0|0|0"
                                widths  ="500|0|2000|3000|800|1000|1000"
                                styles  ="width:100%; height:420"
                                sorting ="F"   
                                oncelldblclick="Select()" />
                         </td>
                    </tr>
                 </table>
            </td>
        </tr>
        <tr>
            <td colspan="3">
			    <table border=0 CELLSPACING="0" CELLPADDING="0" width="100%" height="100%" >
				    <tr align="center"> 
					    <td><gw:icon id="btnSelect" img="in" text="OK" styles="width:100"  onclick="Selects()" /></td>
						<td><gw:icon id="btnCancel" img="in" text="EXIT" styles="width:100"  onclick="OnCancel()" /></td> 
					</tr>
			    </table>
		    </td>
        </tr>
    </table>
    
  
</form>

<gw:textbox id="txt_val1"   text="" styles="display:none" />
<gw:textbox id="txt_val2"   text="" styles="display:none" />
<gw:textbox id="txt_val3"   text="" styles="display:none" />
<gw:textbox id="txt_val4"   text="" styles="display:none" />
<gw:textbox id="txtCOMPANY"   text="" styles="display:none" />

</body>
</html>
