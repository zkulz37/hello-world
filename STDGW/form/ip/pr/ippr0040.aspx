<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <script type="text/javascript">
//----------------------------------------------------------------------------

function Loading()
{
    var fpath = System.RootURL + "/form/ip/pr/ippr0041.aspx"; 
    System.OpenModal( fpath , 2000 ,  2000, 'resizable:yes;status:no;fullscreen:yes;titlebar:yes;location:yes');    
}
//----------------------------------------------------------------------------
function LoadingPO()
{
    var fpath = System.RootURL + "/form/ip/pr/ippr0044.aspx"; 
    System.OpenModal( fpath , 2000 ,  2000, 'resizable:yes;status:no;fullscreen:yes;titlebar:yes;location:yes');    
}

    </script>

</head>
<body>
    <!------------------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 40%">
        </tr>
        <tr style="height: 20%" valign="middle">
            <td style="width: 40%">
            </td>
            <td valign="middle" style="width: 20%">
                <table style="width: 100%; height: 100%; background-color: #CCCC99">
                    <tr valign="middle" style="">
                        <td style="width: 30%">
                        </td>
                        <td style="width: 20%" valign="middle">
                            <img  src="btn1.gif" style='width:100%; cursor:pointer' title="Open line monitoring" onclick="Loading()" />
                        </td>
                        <td style="width: 20%" valign="middle">
                             <img  src="btn1_1.gif" style='width:100%; cursor:pointer' title="Open PO status" onclick="LoadingPO()" />
                        </td>
                        <td style="width: 30%">
                        </td>
                    </tr>
                    
                </table>
            </td>
            <td style="width: 40%">
            </td>
        </tr>
        <tr style="height: 40%">
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------------>
</html>
