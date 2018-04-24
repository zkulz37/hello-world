<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBO Plan checking</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var data;
var v_language = "<%=Session("SESSION_LANG")%>";

//"Factor Type|Factor Name|Standard Score|HR Eva|Manager L1|Manager L2|Manager L3|Final Score|HR_OPINION|L1_OPINION|L2_OPINION|L3_OPINION" 

var c_factor_type=0,c_l3_opinion=11;
var check_init=0;



function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    txtEva_Emp_PK.text="<%=Request("p_eva_emp_pk") %>";
    lblEmp.text="<%=Request("p_emp_name") %>";

    onBindData();
    dso_chem00320_v2_01_1.Call("SELECT");

}

function onBindData() 
{
   
    var ctrl = idGrid.GetGridControl();

    ctrl.MergeCells = 2;
    ctrl.MergeCol(c_factor_type) = true;

}


function OnSearch()
{
    if(check_init==1)
        dso_chem00320_v2_1.Call("SELECT");
}

function OnDataReceive(obj)
{
     if(obj.id=="dso_chem00320_v2_01_1")
    {
        
        auto_resize_column(idGrid,0,c_l3_opinion,9);
        idGrid.Subtotal( 0, 2, 0, '2!3!4!5!6!7!8');
    }
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}





</script>

<body>


<gw:data id="dso_chem00320_v2_01_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" parameter="0" function="hr_sel_chem00320_v2_01_1" procedure="">  
                <input bind="idGrid">  
                    <input bind="txtEva_Emp_PK" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>



   <table id="main" cellpadding="0" cellspacing="0" border=0  style="width:100%;height:100%; margin-left:0; margin-top:0">
        <tr style="width:100%;height:1%">
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        </tr>
        <tr style="width:100%;height:1%">
            <td colspan=20>&nbsp;</td>
            <td colspan=60><gw:label id="lblEmp" styles="font-weight:bold; color:red; font-size: 16; text-align:center" text="" /></td>
            <td colspan=20>&nbsp;</td>
        </tr>
        
        <tr style="height: 94%">
                <td colspan=100>
                    <gw:grid id="idGrid" 
                        header="Factor Type|Factor Name|S Score|Self Score|HR Eva|M.L1|M.L2|M.L3|F.Score|_HR_OPINION|_L1_OPINION|_L2_OPINION|_L3_OPINION|_PK" 
                        format="0|0|-0|-0|-0|-0|-0|-0|-0|-0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                        sorting='T' styles="width:100%; height:100%" />
                </td>
            </tr>
    </table>


</body>

<gw:textbox id="txtEva_Emp_PK" style="display:none" />

</html>
