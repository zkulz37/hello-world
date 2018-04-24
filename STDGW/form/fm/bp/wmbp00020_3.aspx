<%@ Page Language="C#" %> 
<%@ Import Namespace = "System.Web" %>
<%@ Import Namespace = "System.Web.Security" %>
<%@ Import Namespace = "System.Security.Principal" %>
<%@ Import Namespace = "System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("comm");%>
 
 <script>
    //-------------------------------------------------------------------------
  function openPopup(index)
     {
	    var fpath = '';
	    switch(index)
	    {  
	        case 0:
	            fpath = System.RootURL + "/form/fm/bp/wmbp00020_3_1.aspx";
	            alert(fpath);
	            //window.open(fpath);
	           // var aValue  = Window.Open(  fpath , 550 , 500 , 'resizable:yes;status:yes');
	           // if ( aValue != null )
	            {        
	             
	            }	
	        break;
	    }
    }
 </script>
 
<body>
    <form id="form1" runat="server">
        <table width=100%>
            <tr>
                <td width="10%">Request Date&nbsp;</td>
                <td width="10%"><gw:datebox id="dtMRDateST" lang="1" /></td>
                <td width="1%">~</td>
                <td width="10%"><gw:datebox id="dtMRDateET" lang="1" /></td>
                <td width="5%" align=right>MR No &nbsp;</td>
                <td width="10%"><gw:textbox id="txtMRNo"  styles="width:100%;" /></td>
                <td width="5%" align=right><a title="Click here to select Charger" onclick="openPopup(0)" href="#tips" style="text-decoration : none; color=#0000FF"><b>&nbsp;&nbsp;Item&nbsp;&nbsp;</b></a></td>
                <td width="10%"><gw:textbox id="txtItem" styles="width:100%;" /></td>
                <td width="10%"></td>
                <td width="2%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch(0)" /></td>
                <td width="2%"><gw:imgbtn id="btnSelect" img="select" alt="Select" text="Select" onclick="onSearch(0)" /></td>
                <td width="2%"><gw:imgbtn id="btnSelectAll" img="selectall" alt="Select All" text="Select All" onclick="onSearch(0)" /></td>
                <td width="2%"><gw:imgbtn id="btnUnSelect" img="deselectall" alt="Deselect" text="Deselect All" onclick="onSearch(0)" /></td>
                <td width="2%"><gw:imgbtn id="btnExit" img="cancel" alt="Exit" text="Exit" onclick="onSearch(0)" /></td>
            </tr>
            <tr>
                <td colspan="14" >
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <gw:grid
                        id="grdSTitemSpec"
                        header="_PK|_TPR_PURORD_PK|_TPR_PORREQD_PK|Select|Project|Req Date|MR No|_TCO_ITEM_PK|Item Code|Item Name|Quantity|Balance|PO Qty. Rec"
                        format="0|0|0|0|3|0|0|0|0|0|0|3|0"
                        aligns="1|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="||||||||||||"
                        editcol="0|0|0|1|1|1|1|0|0|0|0|0|0"
                        widths="0|0|0|800|2000|1500|1500|0|1000|2500|1000|1000|1000"
                        styles="width:100%; height:450"
                        sorting="F"
                        onafteredit="OnGridCellAfterEdit(this)"
                        oncelldblclick="OnGridCellDoubleClick(this)"
                        param="0,1,2,3,4,5,6,7,8,9,10,11,12"  />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
