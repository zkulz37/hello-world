<!-- #include file="../../../system/lib/form.inc"  -->

<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    System.Translate(document);
     var user_id = "<%=Session("LOGIN_ID")%>";
     
    txt_work_mon.text   ="<%=Request.querystring("SalMon")%>"; 
    Company.text        ="<%=Request.querystring("Company")%>"; 
    CostCenterPK.text   ="<%=Request.querystring("CostCenterPK")%>"; 
    CostTypePK.text     ="<%=Request.querystring("CostTypePK")%>"; 
    Sal_Group.text      ="<%=Request.querystring("Sal_Group")%>"; 
    CostGroupPK.text    ="<%=Request.querystring("CostGroup_pk")%>"; 
    OnSearch();
  
  	
}
//-------------------------------------------
function OnSearch()
{
    
	datSearchCheckCostCenter.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datSearchCheckCostCenter")
    {
        bind_No();
        auto_resize_column(idgrid,0,idgrid.cols-1,9); 
         
    }
    
}
function bind_No()
{
    var num=0;
    for (var i = 1; i < idgrid.rows; i++) {
      idgrid.SetGridText(i,0,i);
    }
    idgrid.Subtotal(  0 ,2 , -1, "8", '###,###,###.##'); 
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

</script>
<body  >
 <gw:data id="datSearchCheckCostCenter" onreceive="OnDataReceive(this)" > 
        <xml>
            <dso type="grid" function="AC_SEL_60140120_SLIP_LIST_POUP">
                <input bind="idgrid">
                    <input bind="Company"/>
                    <input bind="txt_work_mon"/>
                    <input bind="CostCenterPK"/>
                    <input bind="Sal_Group"/>
                    <input bind="CostGroupPK"/>
                    <input bind="CostTypePK"/>
                </input>
                <output bind="idgrid"/>
            </dso>
        </xml>
</gw:data>
<!------------------------------->
  <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        
        <tr style="width: 100%; height: 95%">
            <td width="100%">
               <gw:grid id="idgrid" header="No|Dept|Emp ID|Full Name|_Work Month|Cost Center|Cost Group|Cost Type|Trans Amount"
				format="0|0|0|0|0|0|0|0|1" 
				aligns="0|0|1|0|0|0|0|0|0" 
				defaults="||||||||" 
				editcol="0|0|0|0|0|0|0|0"
				widths="1000|2000|1500|2000|1500|2500|2000|1000|1000" 
				styles="width:100%; height:100%"
				sorting="T" />
                   
            </td>
        </tr>
    </table>
<gw:textbox id="Company"  styles="width:100%;display:none"/>
<gw:textbox id="txt_work_mon"  styles="width:100%;display:none"/>
<gw:textbox id="CostCenterPK"  styles="width:100%;display:none"/>
<gw:textbox id="Sal_Group"  styles="width:100%;display:none"/>
<gw:textbox id="CostTypePK"  styles="width:100%;display:none"/>
<gw:textbox id="CostGroupPK"  styles="width:100%;display:none"/>



</body>
</html>
