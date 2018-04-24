<%@ Page Language="C#" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>BOM Inquiry</title>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" cellpadding=0  cellspacing=0>            
            <tr>
                <td width="20%">Item Code</td>
                <td width="40%"><gw:textbox id="txtItemCode"   styles="width:100%;" /></td>
                <td width="1%"><gw:imgbtn id="btnReset" img="reset" alt="Reset" text="Reset" onclick="txtItemCode.text='';" /></td>
                <td width="37%"></td>
                <td width="1%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="" /></td>
                <td width="1%"><gw:icon img="in" id="btnClose" alt="Close" text="Close" onclick="window.close();" /></td>
            </tr>
            <tr>
                <td width="20%">Item Name</td>
                <td width="40%"><gw:textbox id="txtItemName"   styles="width:100%;" /></td>
                <td width="1%"><gw:imgbtn id="btnReset1" img="reset" alt="Reset" text="Reset" onclick="txtItemName.text='';" /></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="6">
                    <gw:grid id='grdBOMList'
                        header='_Pk|Item Code|Item Name'
                        format='0|0|0'
                        aligns='0|1|1'
                        defaults='||'
                        editcol='0|0|0'
                        widths='0|3000|2500'
                        sorting='T'
                        styles='width:100%; height:300'
                        oncelldblclick="View()"
                        acceptNullDate='true'
                    />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
