<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Golf Bag Fee Setup</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
    var data ="#4.5;4.5|#9;9|#18;18|#27;27|#36;36|#45;45|#54;54"; 
        grdBagFee.SetComboFormat(2,data);
        data= "<%=ESysLib.SetListDataSQL("SELECT pk,NAME FROM tcm_member_type WHERE DEL_IF=0   order by 2" )%>||Select All"; 
        lstMemberType.SetDataText(data);
        lstMemberType.value='';
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT pk,NAME FROM tcm_member_type WHERE DEL_IF=0   order by 2")%>";
	    grdBagFee.SetComboFormat(3, data);
        OnSearch();
}
function MoneyFormat()
{
    var fg=grdBagFee.GetGridControl();
	    fg.ColFormat(4) = "#,###,###,###,###,###.##";
		fg.ColFormat(5) = "#,###,###,###,###,###.##";
}
function OnAddnew()
{
    if(lstMemberType.value!='')
    {
        grdBagFee.AddRow();
        for(var i=1;i<grdBagFee.rows;i++)
              {
                if(grdBagFee.GetGridData(i,0) == "")
                 {
                    grdBagFee.SetGridText(i,0,grdBagFee.rows - 1);
                    grdBagFee.SetGridText(i,3,lstMemberType.value);
                 }
              }
     }         
     else
        {
            alert("Please Choose Member Type.");
        }         
}
function OnSearch()
{
    dat_griddetail.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdBagFee.DeleteRow();
        dat_griddetail.Call();
    }
    else
    {
        dat_griddetail.Call("SELECT");
    }
}
function OnSave()
{
//    if(CheckData() && CheckDuplicate() == true)
//    {
        dat_griddetail.Call();
    // }
}
function CheckData()
{
    for(var i=1;i<grdBagFee.rows;i++)
          {
            if(grdBagFee.GetGridData(i,2) == "")
             {
                alert("Please input ID at row "+ i);
                
                return false;
             }
             if(grdBagFee.GetGridData(i,3) == "")
             {
                alert("Please input Name at row "+i);
                return false;
             }
             
          }
          return true;
}
</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_griddetail"  onreceive="" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9" function="CRM.sp_sel_jabs00080" procedure="CRM.sp_upd_jabs00080"> 
            <input bind="grdBagFee">                    
                <input bind="lstMemberType" /> 
            </input> 
            <output bind="grdBagFee" />
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td width="15%">
                                                        Member Type</td>
                                                    <td width="70%">
                                                        <gw:list id="lstMemberType" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
                                                    <td width="3%"></td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" text="Process" onclick="OnAddnew()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            
                            <gw:grid id="grdBagFee" header="_No|_PK|Hole Type|Member Type|Weekday Fee USD|Weekend Fee USD|Valid From|Valid To|Description|Use YN"
                                format="0|0|0|0|0|0|4|4|0|3" aligns="0|0|0|0|3|3|0|0|0|0" defaults="|||||||||" editcol="1|1|1|1|1|1|1|1|1|1"
                                widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="T"  autosize="T" check="||0|0||||||" onafteredit="MoneyFormat()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
</body>
</html>
